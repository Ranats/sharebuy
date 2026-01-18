import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';
import 'dart:math';

import '../domain/group.dart';
import '../../auth/data/auth_repository.dart';

part 'group_repository.g.dart';

@riverpod
GroupRepository groupRepository(Ref ref) {
  return GroupRepository(FirebaseFirestore.instance);
}

@riverpod
Stream<List<Group>> myGroups(Ref ref) {
  final user = ref.watch(authStateChangesProvider).asData?.value;
  if (user == null) return const Stream.empty();
  return ref.watch(groupRepositoryProvider).watchMyGroups(user.uid);
}

class GroupRepository {
  final FirebaseFirestore _firestore;

  GroupRepository(this._firestore);

  CollectionReference<Group> get _groupsRef => _firestore
      .collection('groups')
      .withConverter(
        fromFirestore: (doc, _) => Group.fromJson(doc.data()!..['id'] = doc.id),
        toFirestore: (model, _) => model.toJson()..remove('id'),
      );

  Stream<List<Group>> watchMyGroups(String uid) {
    return _groupsRef
        .where('memberUids', arrayContains: uid)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Future<String> createGroup(String name, String uid) async {
    final inviteCode = _generateInviteCode();
    final docRef = _groupsRef.doc();

    final group = Group(
      id: docRef.id, // Placeholder
      name: name,
      createdAt: DateTime.now(),
      createdBy: uid,
      inviteCode: inviteCode,
      memberCount: 1,
      memberUids: [uid],
    );

    // Batch to write group and adding member subcollection is better
    final batch = _firestore.batch();
    batch.set(docRef, group);

    final memberRef = docRef.collection('members').doc(uid);
    final member = GroupMember(
      uid: uid,
      role: 'owner',
      joinedAt: DateTime.now(),
    );
    batch.set(memberRef, member.toJson());

    await batch.commit();
    return docRef.id;
  }

  Future<void> joinGroup(String inviteCode, String uid) async {
    // 1. Find group by invite code
    final query = await _groupsRef
        .where('inviteCode', isEqualTo: inviteCode)
        .limit(1)
        .get();
    if (query.docs.isEmpty) {
      throw Exception('Invalid invite code');
    }
    final groupDoc = query.docs.first;
    final group = groupDoc.data();

    if (group.memberUids.contains(uid)) {
      return; // Already joined
    }

    final batch = _firestore.batch();

    // Update group members array and count
    batch.update(groupDoc.reference, {
      'memberUids': FieldValue.arrayUnion([uid]),
      'memberCount': FieldValue.increment(1),
    });

    // Add to members subcollection
    final memberRef = groupDoc.reference.collection('members').doc(uid);
    final member = GroupMember(
      uid: uid,
      role: 'member',
      joinedAt: DateTime.now(),
    );
    batch.set(memberRef, member.toJson());

    await batch.commit();
  }

  String _generateInviteCode() {
    const chars = 'ABCDEFGHJKLMNPQRSTUVWXYZ23456789'; // No I, 0, 1, O
    final rnd = Random();
    return String.fromCharCodes(
      Iterable.generate(6, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))),
    );
  }

  Future<void> updateGroup(String groupId, String name) async {
    await _groupsRef.doc(groupId).update({'name': name});
  }

  Future<void> deleteGroup(String groupId) async {
    await _groupsRef.doc(groupId).delete();
  }

  Future<void> leaveGroup(String groupId, String uid) async {
    final batch = _firestore.batch();
    final groupRef = _groupsRef.doc(groupId);

    // Update group doc
    batch.update(groupRef, {
      'memberUids': FieldValue.arrayRemove([uid]),
      'memberCount': FieldValue.increment(-1),
    });

    // Delete member doc
    final memberRef = groupRef.collection('members').doc(uid);
    batch.delete(memberRef);

    await batch.commit();
  }
}
