import 'dart:math';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sharebuy/features/auth/data/auth_repository.dart';
import 'package:sharebuy/features/auth/domain/app_user.dart';
import 'package:sharebuy/features/group/data/group_repository.dart';
import 'package:sharebuy/features/group/domain/group.dart';
import 'package:sharebuy/features/list/data/list_repository.dart';
import 'package:sharebuy/features/list/domain/shopping_list.dart';

/// Singleton In-Memory Database with SharedPrefs Persistence
class MockDatabase {
  static final MockDatabase instance = MockDatabase._();

  MockDatabase._() {
    init();
  }

  // Auth State
  AppUser? _currentUser;
  final _authController = StreamController<AppUser?>.broadcast();

  Stream<AppUser?> get authStateChanges {
    return _authController.stream.startWith(_currentUser);
  }

  AppUser? get currentUser => _currentUser;

  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();

    // Load User
    final userJson = prefs.getString('mock_user');
    if (userJson != null) {
      _currentUser = AppUser.fromJson(jsonDecode(userJson));
      _authController.add(_currentUser);
    }

    // Load Groups
    final groupsJson = prefs.getString('mock_groups');
    if (groupsJson != null) {
      final Map<String, dynamic> decoded = jsonDecode(groupsJson);
      decoded.forEach((key, value) {
        groups[key] = Group.fromJson(value);
      });
    }

    // Load Members
    final membersJson = prefs.getString('mock_members');
    if (membersJson != null) {
      final Map<String, dynamic> decoded = jsonDecode(membersJson);
      decoded.forEach((groupId, membersMap) {
        groupMembers[groupId] = (membersMap as List)
            .map((e) => GroupMember.fromJson(e))
            .toList();
      });
    }

    // Load Lists
    final listsJson = prefs.getString('mock_lists');
    if (listsJson != null) {
      final Map<String, dynamic> decoded = jsonDecode(listsJson);
      decoded.forEach((groupId, listsMap) {
        groupLists[groupId] = (listsMap as Map<String, dynamic>).map(
          (k, v) => MapEntry(k, ShoppingList.fromJson(v)),
        );
      });
    }

    // Load Items
    final itemsJson = prefs.getString('mock_items');
    if (itemsJson != null) {
      final Map<String, dynamic> decoded = jsonDecode(itemsJson);
      decoded.forEach((groupId, groupMap) {
        groupListItems[groupId] = (groupMap as Map<String, dynamic>).map(
          (listId, itemsMap) => MapEntry(
            listId,
            (itemsMap as Map<String, dynamic>).map(
              (itemId, itemData) =>
                  MapEntry(itemId, ShoppingItem.fromJson(itemData)),
            ),
          ),
        );
      });
    }
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();

    Object? toEncodable(dynamic object) {
      if (object is Timestamp) {
        return object.toDate().toIso8601String();
      }
      return object;
    }

    // Save User
    if (_currentUser != null) {
      await prefs.setString(
        'mock_user',
        jsonEncode(_currentUser!.toJson(), toEncodable: toEncodable),
      );
    } else {
      await prefs.remove('mock_user');
    }

    // Save Groups
    await prefs.setString(
      'mock_groups',
      jsonEncode(
        groups.map((k, v) => MapEntry(k, v.toJson())),
        toEncodable: toEncodable,
      ),
    );

    // Save Members
    await prefs.setString(
      'mock_members',
      jsonEncode(
        groupMembers.map(
          (k, v) => MapEntry(k, v.map((e) => e.toJson()).toList()),
        ),
        toEncodable: toEncodable,
      ),
    );

    // Save Lists
    await prefs.setString(
      'mock_lists',
      jsonEncode(
        groupLists.map(
          (k, v) => MapEntry(k, v.map((k2, v2) => MapEntry(k2, v2.toJson()))),
        ),
        toEncodable: toEncodable,
      ),
    );

    // Save Items
    await prefs.setString(
      'mock_items',
      jsonEncode(
        groupListItems.map(
          (k, v) => MapEntry(
            k,
            v.map(
              (k2, v2) =>
                  MapEntry(k2, v2.map((k3, v3) => MapEntry(k3, v3.toJson()))),
            ),
          ),
        ),
        toEncodable: toEncodable,
      ),
    );
  }

  void signIn(AppUser user) {
    _currentUser = user;
    _authController.add(_currentUser);
    _save();
  }

  void signOut() {
    _currentUser = null;
    _authController.add(null);
    _save();
  }

  // Data Stores
  final Map<String, Group> groups = {};
  final Map<String, List<GroupMember>> groupMembers = {}; // groupId -> members
  final Map<String, Map<String, ShoppingList>> groupLists =
      {}; // groupId -> {listId -> List}
  final Map<String, Map<String, Map<String, ShoppingItem>>> groupListItems =
      {}; // groupId -> listId -> {itemId -> Item}

  final _updateController = StreamController<void>.broadcast();

  void notifyUpdate() {
    _updateController.add(null);
    _save();
  }

  Stream<T> watch<T>(T Function() selector) {
    return _updateController.stream.startWith(null).map((_) => selector());
  }
}

extension StreamStartWith<T> on Stream<T> {
  Stream<T> startWith(T value) {
    return Stream.value(value).concatWith([this]);
  }
}

extension StreamConcatWith<T> on Stream<T> {
  Stream<T> concatWith(Iterable<Stream<T>> other) async* {
    yield* this;
    for (final stream in other) {
      yield* stream;
    }
  }
}

// --- FAKE REPOSITORIES ---

class FakeAuthRepository implements AuthRepository {
  final _db = MockDatabase.instance;

  @override
  Stream<AppUser?> authStateChanges() => _db.authStateChanges;

  @override
  AppUser? get currentUser => _db.currentUser;

  @override
  Future<AppUser?> signInAnonymously() async {
    final user = AppUser(
      uid: 'mock-user-${DateTime.now().millisecondsSinceEpoch}',
      email: null,
      displayName: 'Guest User',
      photoURL: null,
    );
    _db.signIn(user);
    return user;
  }

  @override
  Future<AppUser?> signInWithGoogle() async {
    // Simulate successful Google Sign In
    // Use stable ID to allow testing persistence across logouts (in-memory)
    final user = AppUser(
      uid: 'mock-google-user-1',
      email: 'test@example.com',
      displayName: 'Google User',
      photoURL: 'https://via.placeholder.com/150',
    );
    _db.signIn(user);
    return user;
  }

  @override
  Future<void> signOut() async {
    _db.signOut();
  }

  @override
  Future<void> deleteAccount() async {
    // In Mock, just sign out and maybe clear data if we want strict simulation
    // For now, sign out is sufficient to simulate "gone"
    _db.signOut();
  }

  // Implicit override required by interface structure if exact match needed?
  // Since we are replacing the provider implementation, we just need to match public API called by app.
  // The provider expects `AuthRepository` return type.
  // Dart interface implementation requires all members.
  // AuthRepository has private fields in constructor, but implemented class only cares about public.
}

class FakeGroupRepository implements GroupRepository {
  final _db = MockDatabase.instance;

  @override
  Stream<List<Group>> watchMyGroups(String uid) {
    return _db.watch(() {
      return _db.groups.values.where((g) => g.memberUids.contains(uid)).toList()
        ..sort(
          (a, b) => (b.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0))
              .compareTo(a.createdAt ?? DateTime.fromMillisecondsSinceEpoch(0)),
        );
    });
  }

  @override
  Future<String> createGroup(String name, String uid) async {
    final id = 'group-${DateTime.now().millisecondsSinceEpoch}';
    final inviteCode = _generateInviteCode();
    final group = Group(
      id: id,
      name: name,
      createdAt: DateTime.now(),
      createdBy: uid,
      inviteCode: inviteCode,
      memberCount: 1,
      memberUids: [uid],
    );

    _db.groups[id] = group;
    _db.groupMembers[id] = [
      GroupMember(uid: uid, role: 'owner', joinedAt: DateTime.now()),
    ];
    _db.notifyUpdate();
    return id;
  }

  @override
  Future<void> joinGroup(String inviteCode, String uid) async {
    try {
      final groupEntry = _db.groups.entries.firstWhere(
        (e) => e.value.inviteCode == inviteCode,
      );
      final group = groupEntry.value;
      if (group.memberUids.contains(uid)) return;

      final updatedGroup = group.copyWith(
        memberCount: group.memberCount + 1,
        memberUids: [...group.memberUids, uid],
      );
      _db.groups[group.id] = updatedGroup;

      final members = _db.groupMembers[group.id] ?? [];
      members.add(
        GroupMember(uid: uid, role: 'member', joinedAt: DateTime.now()),
      );
      _db.groupMembers[group.id] = members;

      _db.notifyUpdate();
    } catch (e) {
      throw Exception('Invalid invite code');
    }
  }

  @override
  Future<void> updateGroup(String groupId, String name) async {
    if (!_db.groups.containsKey(groupId)) return;
    _db.groups[groupId] = _db.groups[groupId]!.copyWith(name: name);
    _db.notifyUpdate();
  }

  @override
  Future<void> deleteGroup(String groupId) async {
    _db.groups.remove(groupId);
    _db.groupMembers.remove(groupId);
    _db.groupLists.remove(groupId);
    _db.groupListItems.remove(groupId);
    _db.notifyUpdate();
  }

  @override
  Future<void> leaveGroup(String groupId, String uid) async {
    if (!_db.groups.containsKey(groupId)) return;
    final group = _db.groups[groupId]!;
    if (!group.memberUids.contains(uid)) return;

    final updatedGroup = group.copyWith(
      memberUids: group.memberUids.where((id) => id != uid).toList(),
      memberCount: max(0, group.memberCount - 1),
    );
    _db.groups[groupId] = updatedGroup;

    _db.groupMembers[groupId]?.removeWhere((m) => m.uid == uid);
    _db.notifyUpdate();
  }

  String _generateInviteCode() {
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789';
    final rnd = Random();
    return String.fromCharCodes(
      Iterable.generate(6, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))),
    );
  }
}

class FakeListRepository implements ListRepository {
  final _db = MockDatabase.instance;

  @override
  Stream<List<ShoppingList>> watchLists(String groupId) {
    return _db.watch(() {
      final lists =
          _db.groupLists[groupId]?.values.where((l) => !l.archived).toList() ??
          [];
      lists.sort((a, b) => a.order.compareTo(b.order));
      return lists;
    });
  }

  @override
  Stream<List<ShoppingItem>> watchItems(String groupId, String listId) {
    return _db.watch(() {
      final itemsMap = _db.groupListItems[groupId]?[listId];
      if (itemsMap == null) return [];
      return itemsMap.values.toList();
    });
  }

  @override
  Future<void> createList(String groupId, String name, String uid) async {
    final id = 'list-${DateTime.now().millisecondsSinceEpoch}';
    final list = ShoppingList(
      id: id,
      name: name,
      updatedAt: DateTime.now(),
      updatedBy: uid,
    );

    if (!_db.groupLists.containsKey(groupId)) {
      _db.groupLists[groupId] = {};
    }
    _db.groupLists[groupId]![id] = list;
    _db.notifyUpdate();
  }

  @override
  Future<void> updateList(String groupId, String listId, String name) async {
    final list = _db.groupLists[groupId]?[listId];
    if (list != null) {
      final updated = list.copyWith(name: name, updatedAt: DateTime.now());
      _db.groupLists[groupId]![listId] = updated;
      _db.notifyUpdate();
    }
  }

  @override
  Future<void> deleteList(String groupId, String listId) async {
    // Mock soft delete (remove from list or mark archived? Mock DB just removes for now)
    // Actually our watcher doesn't filter archived in Mock DB unless we implement it.
    // Let's just remove it for Mock.
    _db.groupLists[groupId]?.remove(listId);
    _db.notifyUpdate();
  }

  @override
  Future<void> updateItem(
    String groupId,
    String listId,
    ShoppingItem item,
  ) async {
    if (!_db.groupListItems.containsKey(groupId)) return;
    if (!_db.groupListItems[groupId]!.containsKey(listId)) return;

    _db.groupListItems[groupId]![listId]![item.id] = item;
    _db.notifyUpdate();
  }

  @override
  Future<void> addItem(
    String groupId,
    String listId,
    String name,
    String uid,
  ) async {
    final id = 'item-${DateTime.now().millisecondsSinceEpoch}';
    final item = ShoppingItem(
      id: id,
      name: name,
      updatedAt: DateTime.now(),
      updatedBy: uid,
      createdAt: DateTime.now(),
      order: DateTime.now().millisecondsSinceEpoch,
    );

    if (!_db.groupListItems.containsKey(groupId)) {
      _db.groupListItems[groupId] = {};
    }
    if (!_db.groupListItems[groupId]!.containsKey(listId)) {
      _db.groupListItems[groupId]![listId] = {};
    }
    _db.groupListItems[groupId]![listId]![id] = item;
    _db.notifyUpdate();
  }

  @override
  Future<void> reorderItems(
    String groupId,
    String listId,
    List<ShoppingItem> items,
  ) async {
    // In Mock, just update the items with new order
    if (!_db.groupListItems.containsKey(groupId)) return;
    if (!_db.groupListItems[groupId]!.containsKey(listId)) return;

    for (var item in items) {
      _db.groupListItems[groupId]![listId]![item.id] = item;
    }
    _db.notifyUpdate();
  }

  @override
  Future<void> deleteCompletedItems(String groupId, String listId) async {
    if (!_db.groupListItems.containsKey(groupId)) return;
    if (!_db.groupListItems[groupId]!.containsKey(listId)) return;

    _db.groupListItems[groupId]![listId]!.removeWhere(
      (key, item) => item.status == 'bought',
    );
    _db.notifyUpdate();
  }

  @override
  Future<void> updateItemStatus(
    String groupId,
    String listId,
    String itemId,
    String status,
    String uid,
  ) async {
    final item = _db.groupListItems[groupId]?[listId]?[itemId];
    if (item != null) {
      final updated = item.copyWith(
        status: status,
        updatedAt: DateTime.now(),
        updatedBy: uid,
        boughtAt: status == 'bought' ? DateTime.now() : null,
      );
      _db.groupListItems[groupId]![listId]![itemId] = updated;
      _db.notifyUpdate();
    }
  }

  @override
  Future<void> deleteItem(String groupId, String listId, String itemId) async {
    _db.groupListItems[groupId]?[listId]?.remove(itemId);
    _db.notifyUpdate();
  }

  @override
  Future<void> restoreItem(
    String groupId,
    String listId,
    ShoppingItem item,
  ) async {
    if (!_db.groupListItems.containsKey(groupId)) {
      _db.groupListItems[groupId] = {};
    }
    if (!_db.groupListItems[groupId]!.containsKey(listId)) {
      _db.groupListItems[groupId]![listId] = {};
    }
    _db.groupListItems[groupId]![listId]![item.id] = item;
    _db.notifyUpdate();
  }
}
