import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/utils/async_value_ui.dart';
import 'auth_controller.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  Future<void> _launchUrl(String urlString) async {
    final uri = Uri.parse(urlString);
    try {
      if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
        debugPrint('Could not launch $urlString');
      }
    } catch (e) {
      debugPrint('Error launching URL: $e');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue>(
      authControllerProvider,
      (_, state) => state.showSnackBarOnError(context),
    );
    final state = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Login')), // Optional
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'うちメモ',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            if (state.isLoading)
              const CircularProgressIndicator()
            else
              FilledButton.icon(
                onPressed: () {
                  ref.read(authControllerProvider.notifier).signInWithGoogle();
                },
                icon: const Icon(Icons.login),
                label: const Text('Googleでログイン'),
              ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () {
                ref.read(authControllerProvider.notifier).signInAnonymously();
              },
              icon: const Icon(Icons.person_outline),
              label: const Text('ゲストとして利用'),
              style: FilledButton.styleFrom(backgroundColor: Colors.grey),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => _launchUrl(
                    'https://ranats.github.io/sharebuy/TermsOfService/Japanese',
                  ),
                  child: const Text('利用規約', style: TextStyle(fontSize: 12)),
                ),
                const Text('|', style: TextStyle(color: Colors.grey)),
                TextButton(
                  onPressed: () => _launchUrl(
                    'https://ranats.github.io/sharebuy/PrivacyPolicy/Japanese',
                  ),
                  child: const Text(
                    'プライバシーポリシー',
                    style: TextStyle(fontSize: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
