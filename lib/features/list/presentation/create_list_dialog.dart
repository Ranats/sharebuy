import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../auth/data/auth_repository.dart';
import '../data/list_repository.dart';

class CreateListDialog extends ConsumerStatefulWidget {
  const CreateListDialog({super.key, required this.groupId});
  final String groupId;

  @override
  ConsumerState<CreateListDialog> createState() => _CreateListDialogState();
}

class _CreateListDialogState extends ConsumerState<CreateListDialog> {
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
          .createList(widget.groupId, name, user.uid);
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
      title: const Text('新しいリスト'),
      content: Form(
        key: _formKey,
        child: TextFormField(
          controller: _nameController,
          decoration: const InputDecoration(
            labelText: 'リスト名',
            hintText: '例: 食品, 日用品',
          ),
          autofocus: true,
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'リスト名を入力してください';
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
              : const Text('作成'),
        ),
      ],
    );
  }
}
