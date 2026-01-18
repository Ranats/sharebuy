import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:sharebuy/features/list/domain/shopping_list.dart';

part 'list_repository.g.dart';

@riverpod
ListRepository listRepository(Ref ref) {
  return ListRepository(FirebaseFirestore.instance);
}

class ListRepository {
  final FirebaseFirestore _firestore;

  ListRepository(this._firestore);

  // Groups -> Lists
  CollectionReference<ShoppingList> _listsRef(String groupId) => _firestore
      .collection('groups/$groupId/lists')
      .withConverter(
        fromFirestore: (doc, _) =>
            ShoppingList.fromJson(doc.data()!..['id'] = doc.id),
        toFirestore: (model, _) => model.toJson()..remove('id'),
      );

  // Groups -> Lists -> Items
  CollectionReference<ShoppingItem> _itemsRef(String groupId, String listId) =>
      _firestore
          .collection('groups/$groupId/lists/$listId/items')
          .withConverter(
            fromFirestore: (doc, _) =>
                ShoppingItem.fromJson(doc.data()!..['id'] = doc.id),
            toFirestore: (model, _) => model.toJson()..remove('id'),
          );

  Stream<List<ShoppingList>> watchLists(String groupId) {
    return _listsRef(groupId)
        .where('archived', isEqualTo: false)
        .orderBy('order')
        .snapshots()
        .map((s) => s.docs.map((d) => d.data()).toList());
  }

  Stream<List<ShoppingItem>> watchItems(String groupId, String listId) {
    return _itemsRef(groupId, listId)
        .orderBy('order')
        .snapshots()
        .map((s) => s.docs.map((d) => d.data()).toList());
  }

  Future<void> createList(String groupId, String name, String uid) async {
    final ref = _listsRef(groupId).doc();
    final list = ShoppingList(
      id: ref.id,
      name: name,
      updatedAt: DateTime.now(),
      updatedBy: uid,
    );
    await ref.set(list);
  }

  Future<void> updateList(String groupId, String listId, String name) async {
    await _listsRef(groupId).doc(listId).update({
      'name': name,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteList(String groupId, String listId) async {
    // Soft delete using archived flag
    await _listsRef(groupId).doc(listId).update({'archived': true});
  }

  Future<void> updateItem(
    String groupId,
    String listId,
    ShoppingItem item,
  ) async {
    await _itemsRef(groupId, listId).doc(item.id).set(item);
  }

  Future<void> addItem(
    String groupId,
    String listId,
    String name,
    String uid,
  ) async {
    final ref = _itemsRef(groupId, listId).doc();
    final now = DateTime.now();
    final item = ShoppingItem(
      id: ref.id,
      name: name,
      updatedAt: now,
      updatedBy: uid,
      createdAt: now,
      order: now.millisecondsSinceEpoch, // Default to added time
    );
    await ref.set(item);
  }

  Future<void> updateItemStatus(
    String groupId,
    String listId,
    String itemId,
    String status,
    String uid,
  ) async {
    final ref = _itemsRef(groupId, listId).doc(itemId);
    await ref.update({
      'status': status,
      'updatedAt': FieldValue.serverTimestamp(),
      'updatedBy': uid,
      'boughtAt': status == 'bought'
          ? FieldValue.serverTimestamp()
          : null, // Reset boughtAt if unchecking
    });
  }

  Future<void> deleteItem(String groupId, String listId, String itemId) async {
    await _itemsRef(groupId, listId).doc(itemId).delete();
  }

  Future<void> restoreItem(
    String groupId,
    String listId,
    ShoppingItem item,
  ) async {
    await _itemsRef(groupId, listId).doc(item.id).set(item);
  }

  Future<void> reorderItems(
    String groupId,
    String listId,
    List<ShoppingItem> items,
  ) async {
    final batch = _firestore.batch();
    for (int i = 0; i < items.length; i++) {
      final docRef = _itemsRef(groupId, listId).doc(items[i].id);
      batch.update(docRef, {'order': items[i].order});
    }
    await batch.commit();
  }

  Future<void> deleteCompletedItems(String groupId, String listId) async {
    final snapshot = await _itemsRef(
      groupId,
      listId,
    ).where('status', isEqualTo: 'bought').get();

    if (snapshot.docs.isEmpty) return;

    final batch = _firestore.batch();
    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }
}
