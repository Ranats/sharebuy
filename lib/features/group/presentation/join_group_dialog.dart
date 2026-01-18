import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../auth/data/auth_repository.dart';
import '../data/group_repository.dart';

class JoinGroupDialog extends ConsumerStatefulWidget {
  const JoinGroupDialog({super.key});

  @override
  ConsumerState<JoinGroupDialog> createState() => _JoinGroupDialogState();
}

class _JoinGroupDialogState extends ConsumerState<JoinGroupDialog> {
  final _codeController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _join() async {
    final code = _codeController.text.trim();
    if (code.length != 6) return;

    final user = ref.read(authRepositoryProvider).currentUser;
    if (user == null) return;

    setState(() => _isLoading = true);
    try {
      await ref
          .read(groupRepositoryProvider)
          .joinGroup(code.toUpperCase(), user.uid);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('参加できませんでした: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('招待コードで参加'),
      content: TextField(
        controller: _codeController,
        decoration: const InputDecoration(
          labelText: '招待コード (6桁)',
          hintText: '例: ABC123',
        ),
        maxLength: 6,
        autofocus: true,
        textCapitalization: TextCapitalization.characters,
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.pop(context),
          child: const Text('キャンセル'),
        ),
        FilledButton(
          onPressed: _isLoading ? null : _join,
          child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Text('参加'),
        ),
      ],
    );
  }
}
