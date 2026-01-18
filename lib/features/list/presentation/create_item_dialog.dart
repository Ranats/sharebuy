import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../auth/data/auth_repository.dart';
import '../data/list_repository.dart';

class CreateItemDialog extends ConsumerStatefulWidget {
  const CreateItemDialog({
    super.key,
    required this.groupId,
    required this.listId,
  });
  final String groupId;
  final String listId;

  @override
  ConsumerState<CreateItemDialog> createState() => _CreateItemDialogState();
}

class _CreateItemDialogState extends ConsumerState<CreateItemDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _create() async {
    if (!_formKey.currentState!.validate()) return;

    final name = _nameController.text.trim();
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user == null) return;

    setState(() => _isLoading = true);
    try {
      await ref
          .read(listRepositoryProvider)
          .addItem(widget.groupId, widget.listId, name, user.uid);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('アイテムを追加'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: 'アイテム名',
            hintText: '例: 牛乳',
          ),
          autofocus: true,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'アイテム名を入力してください';
            }
            return null;
          },
          textInputAction: TextInputAction.done,
          onFieldSubmitted: (_) => _create(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.pop(context),
          child: const Text('キャンセル'),
        ),
        FilledButton(
          onPressed: _isLoading ? null : _create,
          child: _isLoading
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                )
              : const Text('追加'),
        ),
      ],
    );
  }
}
