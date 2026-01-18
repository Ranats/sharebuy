import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../auth/data/auth_repository.dart';
import '../data/list_repository.dart';
import '../domain/shopping_list.dart';
import 'create_item_dialog.dart';
import 'edit_item_dialog.dart';
import '../../../core/widgets/ad_banner.dart';

part 'list_detail_screen.g.dart';

@riverpod
Stream<List<ShoppingItem>> itemsStream(Ref ref, String groupId, String listId) {
  return ref.watch(listRepositoryProvider).watchItems(groupId, listId);
}

class ListDetailScreen extends ConsumerStatefulWidget {
  const ListDetailScreen({
    super.key,
    required this.groupId,
    required this.listId,
  });

  final String groupId;
  final String listId;

  @override
  ConsumerState<ListDetailScreen> createState() => _ListDetailScreenState();
}

class _ListDetailScreenState extends ConsumerState<ListDetailScreen> {
  List<ShoppingItem>? _currentItems;

  @override
  void deactivate() {
    // Navigate away -> Clear all SnackBars safely
    ScaffoldMessenger.maybeOf(context)?.clearSnackBars();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(itemsStreamProvider(widget.groupId, widget.listId), (
      previous,
      next,
    ) {
      if (next.hasValue && next.value != null) {
        // Update local state when stream emits new data (e.g. from backend or optimistic updates)
        setState(() {
          _currentItems = next.value!;
        });
      }
    });

    final itemsAsync = ref.watch(
      itemsStreamProvider(widget.groupId, widget.listId),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('リスト詳細'),
        actions: [
          itemsAsync.when(
            data: (items) {
              // Initial load or fallback
              final effectiveItems = _currentItems ?? items;
              final hasBoughtItems = effectiveItems.any(
                (i) => i.status == 'bought',
              );

              return PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'delete_completed') {
                    _confirmDeleteCompleted(context, ref);
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'delete_completed',
                    enabled: hasBoughtItems,
                    child: const Text('完了済みを削除'),
                  ),
                ],
              );
            },
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
          ),
        ],
      ),
      body: itemsAsync.when(
        data: (items) {
          // Initialize local state if first load
          if (_currentItems == null && items.isNotEmpty) {
            _currentItems = items;
          }
          // If items became empty from backend, sync it
          if (items.isEmpty && (_currentItems?.isNotEmpty ?? false)) {
            _currentItems = [];
          }

          // Use local state for rendering to prevent flicker
          // If null (loading first time or empty), use items (empty)
          final renderItems = _currentItems ?? items;

          if (renderItems.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.shopping_basket_outlined,
                    size: 64,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  const Text('アイテムがありません'),
                  const SizedBox(height: 32),
                  FilledButton.icon(
                    onPressed: () => _showAddItemDialog(context, ref),
                    icon: const Icon(Icons.add),
                    label: const Text('アイテムを追加'),
                  ),
                ],
              ),
            );
          }

          return ReorderableListView.builder(
            itemCount: renderItems.length,
            onReorder: (oldIndex, newIndex) {
              if (oldIndex < newIndex) {
                newIndex -= 1;
              }

              // 1. Update LOCAL state synchronously
              final newList = List<ShoppingItem>.from(renderItems);
              final item = newList.removeAt(oldIndex);
              newList.insert(newIndex, item);

              // Recalculate orders
              final updatedItems = <ShoppingItem>[];
              for (int i = 0; i < newList.length; i++) {
                updatedItems.add(newList[i].copyWith(order: i));
              }

              setState(() {
                _currentItems = updatedItems;
              });

              // 2. Call Repo (Fire and Forget / Optimistic)
              ref
                  .read(listRepositoryProvider)
                  .reorderItems(widget.groupId, widget.listId, updatedItems);
            },
            itemBuilder: (itemContext, index) {
              final item = renderItems[index];
              final isBought = item.status == 'bought';

              return SizedBox(
                key: Key(
                  item.id,
                ), // Key moved to the top-level widget for ReorderableListView
                child: Dismissible(
                  key: Key(item.id),
                  background: Container(
                    color: Colors.green,
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.only(left: 16),
                    child: const Icon(Icons.edit, color: Colors.white),
                  ),
                  secondaryBackground: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(right: 16),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  confirmDismiss: (direction) async {
                    if (direction == DismissDirection.startToEnd) {
                      _showEditItemDialog(context, ref, item);
                      return false;
                    } else {
                      return true;
                    }
                  },
                  onDismissed: (direction) {
                    if (direction == DismissDirection.endToStart) {
                      ref
                          .read(listRepositoryProvider)
                          .deleteItem(widget.groupId, widget.listId, item.id);

                      // Clear previous SnackBars to prevent stacking
                      ScaffoldMessenger.maybeOf(context)?.clearSnackBars();

                      final controller = ScaffoldMessenger.of(context)
                          .showSnackBar(
                            SnackBar(
                              content: const Text('削除しました'),
                              duration: const Duration(milliseconds: 2000),
                              action: SnackBarAction(
                                label: '元に戻す',
                                onPressed: () {
                                  ref
                                      .read(listRepositoryProvider)
                                      .restoreItem(
                                        widget.groupId,
                                        widget.listId,
                                        item,
                                      );
                                },
                              ),
                            ),
                          );

                      // Force close after duration to ensure it disappears even if
                      // accessibility settings allow it to persist longer due to the Action.
                      Future.delayed(const Duration(milliseconds: 2500), () {
                        try {
                          controller.close();
                        } catch (_) {
                          // Ignore if already closed or detached
                        }
                      });
                    }
                  },
                  child: ListTile(
                    key: ValueKey(item.id), // Important for Reorderable
                    leading: Checkbox(
                      value: isBought,
                      onChanged: (val) => _toggleItemStatus(ref, item, val),
                    ),
                    title: Text(
                      item.name,
                      style: TextStyle(
                        decoration: isBought
                            ? TextDecoration.lineThrough
                            : null,
                        color: isBought ? Colors.grey : null,
                      ),
                    ),
                    subtitle: item.note != null && item.note!.isNotEmpty
                        ? Text(item.note!)
                        : null,
                    trailing: ReorderableDragStartListener(
                      index: index,
                      child: const Icon(Icons.drag_handle),
                    ),
                    onTap: () {
                      _toggleItemStatus(ref, item, !isBought);
                    },
                  ),
                ).animate(delay: (30 * index).ms).fadeIn().slideY(begin: 0.1),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, s) => Center(child: Text('Error: $e')),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddItemDialog(context, ref),
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const AdBanner(),
    );
  }

  void _showAddItemDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (_) =>
          CreateItemDialog(groupId: widget.groupId, listId: widget.listId),
    );
  }

  void _showEditItemDialog(
    BuildContext context,
    WidgetRef ref,
    ShoppingItem item,
  ) {
    showDialog(
      context: context,
      builder: (_) => EditItemDialog(
        groupId: widget.groupId,
        listId: widget.listId,
        item: item,
      ),
    );
  }

  void _toggleItemStatus(WidgetRef ref, ShoppingItem item, bool? val) {
    final newStatus = val == true ? 'bought' : 'active';
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user != null) {
      ref
          .read(listRepositoryProvider)
          .updateItemStatus(
            widget.groupId,
            widget.listId,
            item.id,
            newStatus,
            user.uid,
          );
    }
  }

  Future<void> _confirmDeleteCompleted(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('完了済みを削除'),
        content: const Text('チェック済みのアイテムをすべて削除しますか？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('削除'),
          ),
        ],
      ),
    );

    if (result == true) {
      if (mounted) {
        // Perform delete
        ref
            .read(listRepositoryProvider)
            .deleteCompletedItems(widget.groupId, widget.listId);

        ScaffoldMessenger.maybeOf(context)?.clearSnackBars(); // Clear all
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('完了済みを削除しました'),
            duration: Duration(milliseconds: 2000),
          ),
        );
      }
    }
  }
}
