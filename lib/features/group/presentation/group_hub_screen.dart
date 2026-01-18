import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../auth/presentation/auth_controller.dart';
import '../../auth/data/auth_repository.dart';
import '../data/group_repository.dart';
import '../domain/group.dart';
import 'create_group_dialog.dart';
import 'join_group_dialog.dart';
import '../../../core/widgets/ad_banner.dart';

class GroupHubScreen extends ConsumerWidget {
  const GroupHubScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupsAsync = ref.watch(myGroupsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('ホーム'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => context.push('/settings'),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(authControllerProvider.notifier).signOut();
            },
          ),
        ],
      ),
      body: groupsAsync.when(
        data: (groups) {
          if (groups.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.group_off, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  const Text('グループに参加していません'),
                  const SizedBox(height: 32),
                  FilledButton.icon(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (_) => const CreateGroupDialog(),
                    ),
                    icon: const Icon(Icons.add),
                    label: const Text('グループを作成'),
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton.icon(
                    onPressed: () => showDialog(
                      context: context,
                      builder: (_) => const JoinGroupDialog(),
                    ),
                    icon: const Icon(Icons.login),
                    label: const Text('招待コードで参加'),
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: groups.length,
            itemBuilder: (context, index) {
              final group = groups[index];
              return Card(
                elevation: 2,
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  title: Text(
                    group.name,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Row(
                    children: [
                      Text(
                        'メンバー: ${group.memberCount}人\nコード: ${group.inviteCode}',
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        icon: const Icon(Icons.copy, size: 16),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: () async {
                          await Clipboard.setData(
                            ClipboardData(text: group.inviteCode),
                          );
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'コードをコピーしました: ${group.inviteCode}',
                                ),
                              ),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                  isThreeLine: true,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _GroupMenuButton(group: group),
                      const Icon(Icons.arrow_forward_ios, size: 16),
                    ],
                  ),
                  onTap: () => context.go('/groups/${group.id}/lists'),
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: groupsAsync.asData?.value.isNotEmpty == true
          ? FloatingActionButton(
              onPressed: () => showModalBottomSheet(
                context: context,
                builder: (context) => SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.add_circle_outline),
                        title: const Text('グループを作成'),
                        onTap: () {
                          Navigator.pop(context); // Close sheet
                          showDialog(
                            context: context,
                            builder: (_) => const CreateGroupDialog(),
                          );
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.input),
                        title: const Text('招待コードで参加'),
                        onTap: () {
                          Navigator.pop(context); // Close sheet
                          showDialog(
                            context: context,
                            builder: (_) => const JoinGroupDialog(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              child: const Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: const AdBanner(),
    );
  }
}

class _GroupMenuButton extends ConsumerWidget {
  const _GroupMenuButton({required this.group});
  final Group group;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user == null) return const SizedBox();

    final isOwner = group.createdBy == user.uid;

    return PopupMenuButton<String>(
      onSelected: (value) async {
        if (value == 'edit') {
          _showEditDialog(context, ref);
        } else if (value == 'delete') {
          _confirmDelete(context, ref);
        } else if (value == 'leave') {
          _confirmLeave(context, ref, user.uid);
        }
      },
      itemBuilder: (context) => [
        const PopupMenuItem(
          value: 'edit',
          child: Row(
            children: [
              Icon(Icons.edit, size: 20),
              SizedBox(width: 8),
              Text('グループ名を変更'),
            ],
          ),
        ),
        if (isOwner)
          const PopupMenuItem(
            value: 'delete',
            child: Row(
              children: [
                Icon(Icons.delete, color: Colors.red, size: 20),
                SizedBox(width: 8),
                Text('グループを削除', style: TextStyle(color: Colors.red)),
              ],
            ),
          )
        else
          const PopupMenuItem(
            value: 'leave',
            child: Row(
              children: [
                Icon(Icons.exit_to_app, color: Colors.red, size: 20),
                SizedBox(width: 8),
                Text('グループから退出', style: TextStyle(color: Colors.red)),
              ],
            ),
          ),
      ],
    );
  }

  void _showEditDialog(BuildContext context, WidgetRef ref) {
    final controller = TextEditingController(text: group.name);
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('グループ名を変更'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(labelText: 'グループ名'),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('キャンセル'),
          ),
          FilledButton(
            onPressed: () async {
              if (controller.text.isNotEmpty) {
                await ref
                    .read(groupRepositoryProvider)
                    .updateGroup(group.id, controller.text.trim());
                if (context.mounted) Navigator.pop(context);
              }
            },
            child: const Text('保存'),
          ),
        ],
      ),
    );
  }

  Future<void> _confirmDelete(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('グループを削除'),
        content: const Text('本当に削除しますか？\nこの操作は取り消せません。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('削除'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(groupRepositoryProvider).deleteGroup(group.id);
    }
  }

  Future<void> _confirmLeave(
    BuildContext context,
    WidgetRef ref,
    String uid,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('グループから退出'),
        content: const Text('本当に退出しますか？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('退出'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await ref.read(groupRepositoryProvider).leaveGroup(group.id, uid);
    }
  }
}
