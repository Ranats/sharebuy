import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/list_repository.dart';
import '../domain/shopping_list.dart';

class EditListDialog extends ConsumerStatefulWidget {
  const EditListDialog({super.key, required this.groupId, required this.list});

  final String groupId;
  final ShoppingList list;

  @override
  ConsumerState<EditListDialog> createState() => _EditListDialogState();
}

class _EditListDialogState extends ConsumerState<EditListDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.list.name);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await ref
            .read(listRepositoryProvider)
            .updateList(
              widget.groupId,
              widget.list.id,
              _nameController.text.trim(),
            );
        if (mounted) {
          Navigator.of(context).pop();
        }
      } catch (e) {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('エラーが発生しました: $e')));
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('リスト名を変更'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: 'リスト名',
            hintText: '例: スーパー, ドラッグストア',
          ),
          autofocus: true,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'リスト名を入力してください';
            }
            return null;
          },
        ),
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.of(context).pop(),
          child: const Text('キャンセル'),
        ),
        FilledButton(
          onPressed: _isLoading ? null : _submit,
          child: _isLoading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
              : const Text('保存'),
        ),
      ],
    );
  }
}
