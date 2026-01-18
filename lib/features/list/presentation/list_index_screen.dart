import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../data/list_repository.dart';
import '../domain/shopping_list.dart';
import 'create_list_dialog.dart';
import 'edit_list_dialog.dart';

part 'list_index_screen.g.dart';

@riverpod
Stream<List<ShoppingList>> listsStream(Ref ref, String groupId) {
  return ref.watch(listRepositoryProvider).watchLists(groupId);
}

class ListIndexScreen extends ConsumerStatefulWidget {
  const ListIndexScreen({super.key, required this.groupId});
  final String groupId;

  @override
  ConsumerState<ListIndexScreen> createState() => _ListIndexScreenState();
}

class _ListIndexScreenState extends ConsumerState<ListIndexScreen> {
  bool _isEditing = false;
  final Set<String> _selectedIds = {};

  void _toggleEditMode() {
    setState(() {
      _isEditing = !_isEditing;
      _selectedIds.clear();
    });
  }

  void _toggleSelection(String id) {
    setState(() {
      if (_selectedIds.contains(id)) {
        _selectedIds.remove(id);
      } else {
        _selectedIds.add(id);
      }
    });
  }

  Future<void> _deleteSelected() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('リストを削除'),
        content: Text('${_selectedIds.length}件のリストを削除してもよろしいですか？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('削除'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final repo = ref.read(listRepositoryProvider);
      for (final id in _selectedIds) {
        await repo.deleteList(widget.groupId, id);
      }
      _toggleEditMode();
    }
  }

  Future<void> _showEditListDialog(ShoppingList list) async {
    await showDialog(
      context: context,
      builder: (context) => EditListDialog(groupId: widget.groupId, list: list),
    );
  }

  Future<void> _confirmDeleteList(ShoppingList list) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('リストを削除'),
        content: Text('「${list.name}」を削除してもよろしいですか？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('削除'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref
          .read(listRepositoryProvider)
          .deleteList(widget.groupId, list.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final listsAsync = ref.watch(listsStreamProvider(widget.groupId));

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? '${_selectedIds.length}件選択中' : 'リスト一覧'),
        actions: [
          TextButton(
            onPressed: _toggleEditMode,
            style: TextButton.styleFrom(
              foregroundColor:
                  Theme.of(context).appBarTheme.foregroundColor ?? Colors.white,
            ),
            child: Text(_isEditing ? '完了' : '編集'),
          ),
        ],
      ),
      body: listsAsync.when(
        data: (lists) {
          if (lists.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.list_alt, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text('リストがありません'),
                  if (!_isEditing) ...[
                    const SizedBox(height: 32),
                    FilledButton.icon(
                      onPressed: () => _showAddListDialog(context, ref),
                      icon: const Icon(Icons.add),
                      label: const Text('リストを作成'),
                    ),
                  ],
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: lists.length,
            itemBuilder: (context, index) {
              final list = lists[index];
              return ListTile(
                leading: _isEditing
                    ? Checkbox(
                        value: _selectedIds.contains(list.id),
                        onChanged: (_) => _toggleSelection(list.id),
                      )
                    : null,
                title: Text(list.name),
                trailing: _isEditing
                    ? null
                    : PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert),
                        onSelected: (value) {
                          if (value == 'rename') {
                            _showEditListDialog(list);
                          } else if (value == 'delete') {
                            _confirmDeleteList(list);
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'rename',
                            child: Row(
                              children: [
                                Icon(Icons.edit, size: 20),
                                SizedBox(width: 8),
                                Text('名前を変更'),
                              ],
                            ),
                          ),
                          const PopupMenuItem(
                            value: 'delete',
                            child: Row(
                              children: [
                                Icon(Icons.delete, color: Colors.red, size: 20),
                                SizedBox(width: 8),
                                Text('削除', style: TextStyle(color: Colors.red)),
                              ],
                            ),
                          ),
                        ],
                      ),
                onTap: () {
                  if (_isEditing) {
                    _toggleSelection(list.id);
                  } else {
                    context.go('/groups/${widget.groupId}/lists/${list.id}');
                  }
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
      bottomNavigationBar: _isEditing
          ? SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: FilledButton.icon(
                  onPressed: _selectedIds.isNotEmpty ? _deleteSelected : null,
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.red,
                    disabledBackgroundColor: Colors.grey[300],
                  ),
                  icon: const Icon(Icons.delete),
                  label: const Text('削除'),
                ),
              ),
            )
          : null,
      floatingActionButton: !_isEditing
          ? FloatingActionButton(
              onPressed: () => _showAddListDialog(context, ref),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  void _showAddListDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (_) => CreateListDialog(groupId: widget.groupId),
    );
  }
}
