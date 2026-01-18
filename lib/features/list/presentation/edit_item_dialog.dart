import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../auth/data/auth_repository.dart';
import '../../list/data/list_repository.dart';
import '../domain/shopping_list.dart';

class EditItemDialog extends ConsumerStatefulWidget {
  const EditItemDialog({
    super.key,
    required this.groupId,
    required this.listId,
    required this.item,
  });

  final String groupId;
  final String listId;
  final ShoppingItem item;

  @override
  ConsumerState<EditItemDialog> createState() => _EditItemDialogState();
}

class _EditItemDialogState extends ConsumerState<EditItemDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item.name);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    final name = _nameController.text.trim();
    final user = ref.read(authRepositoryProvider).currentUser;
    if (user == null) return;

    setState(() => _isLoading = true);

    final updatedItem = widget.item.copyWith(
      name: name,
      updatedAt: DateTime.now(),
      updatedBy: user.uid,
    );

    try {
      await ref
          .read(listRepositoryProvider)
          .updateItem(widget.groupId, widget.listId, updatedItem);
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('エラーが発生しました: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('アイテムを編集'),
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
          onFieldSubmitted: (_) => _save(),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('キャンセル'),
        ),
        FilledButton(
          onPressed: _isLoading ? null : _save,
          child: _isLoading
              ? SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                )
              : const Text('保存'),
        ),
      ],
    );
  }
}
