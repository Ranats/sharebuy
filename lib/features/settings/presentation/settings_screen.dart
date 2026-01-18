import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../auth/presentation/auth_controller.dart';
import '../../../core/theme/theme_provider.dart';
import 'package:go_router/go_router.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSkin =
        ref.watch(appThemeSelectorProvider).asData?.value ?? 'smart';

    return Scaffold(
      appBar: AppBar(title: const Text('設定')),
      body: ListView(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text('表示設定', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          RadioListTile<String>(
            title: const Text('Smart (Modern)'),
            value: 'smart',
            groupValue: currentSkin,
            onChanged: (val) {
              if (val != null) {
                ref.read(appThemeSelectorProvider.notifier).setSkin(val);
              }
            },
          ),
          RadioListTile<String>(
            title: const Text('Pop (Playful)'),
            value: 'pop',
            groupValue: currentSkin,
            onChanged: (val) {
              if (val != null) {
                ref.read(appThemeSelectorProvider.notifier).setSkin(val);
              }
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.red),
            title: const Text('ログアウト', style: TextStyle(color: Colors.red)),
            onTap: () {
              ref.read(authControllerProvider.notifier).signOut();
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text('アプリについて'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () {
              context.push('/settings/about');
            },
          ),
          const Divider(),

          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'アカウント管理',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.delete_forever, color: Colors.red),
            title: const Text('アカウント削除', style: TextStyle(color: Colors.red)),
            subtitle: const Text('アカウントと全てのデータを削除します'),
            onTap: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('アカウント削除'),
                  content: const Text(
                    '本当にアカウントを削除しますか？\nこの操作は取り消せません。\n作成したリストや参加情報など、全てのデータが削除されます。',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('キャンセル'),
                    ),
                    FilledButton(
                      style: FilledButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('削除する'),
                    ),
                  ],
                ),
              );

              if (confirmed == true && context.mounted) {
                ref.read(authControllerProvider.notifier).deleteAccount();
              }
            },
          ),
        ],
      ),
    );
  }
}
