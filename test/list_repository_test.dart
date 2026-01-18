import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sharebuy/features/list/data/list_repository.dart';
import 'package:sharebuy/core/data/mock_repositories.dart';
import 'package:sharebuy/features/list/domain/shopping_list.dart';

void main() {
  group('FakeListRepository', () {
    late FakeListRepository repository;

    setUp(() async {
      TestWidgetsFlutterBinding.ensureInitialized();
      SharedPreferences.setMockInitialValues({}); // Mock SharedPreferences
      repository = FakeListRepository();
      await MockDatabase.instance.init(); // Ensure DB is init
    });

    test('createList adds a list', () async {
      await repository.createList('group1', 'Test List', 'test-uid');
      final stream = repository.watchLists('group1');
      final lists = await stream.first;
      expect(lists.length, greaterThanOrEqualTo(1));
      expect(lists.first.name, 'Test List');
    });

    test('updateList renames a list', () async {
      await repository.createList('group1', 'Rename Me', 'test-uid');
      final stream = repository.watchLists('group1');
      var lists = await stream.first;
      final listId = lists.first.id;

      await repository.updateList('group1', listId, 'Renamed List');

      final updatedStream = repository.watchLists('group1');
      lists = await updatedStream.first;
      expect(lists.first.name, 'Renamed List');
    });

    test('deleteList removes a list', () async {
      await repository.createList('group1', 'Delete Me', 'test-uid');
      var stream = repository.watchLists('group1');
      var lists = await stream.first;
      final listId = lists.last.id; // Get the one we just made

      await repository.deleteList('group1', listId);

      stream = repository.watchLists('group1');
      lists = await stream.first;
      expect(lists.any((l) => l.id == listId), false);
    });
  });
}
