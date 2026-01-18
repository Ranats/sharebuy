import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  PackageInfo? _packageInfo;

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('アプリについて')),
      body: ListView(
        children: [
          const SizedBox(height: 32),
          Center(
            child: Column(
              children: [
                const Icon(Icons.shopping_cart, size: 64, color: Colors.orange),
                const SizedBox(height: 16),
                Text(
                  _packageInfo?.appName ?? 'ShareBuy',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                Text(
                  'Version ${_packageInfo?.version ?? '-'} (${_packageInfo?.buildNumber ?? '-'})',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          const Divider(),
          ListTile(
            title: const Text('利用規約'),
            trailing: const Icon(Icons.open_in_new, size: 16),
            onTap: () {
              const url =
                  'https://ranats.github.io/sharebuy/TermsOfService/Japanese';
              _launchUrl(url);
            },
          ),
          ListTile(
            title: const Text('プライバシーポリシー'),
            trailing: const Icon(Icons.open_in_new, size: 16),
            onTap: () {
              const url =
                  'https://ranats.github.io/sharebuy/PrivacyPolicy/Japanese';
              _launchUrl(url);
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('ライセンス'),
            trailing: const Icon(Icons.arrow_forward_ios, size: 16),
            onTap: () async {
              showLicensePage(
                context: context,
                applicationName: _packageInfo?.appName ?? 'ShareBuy',
                applicationVersion: _packageInfo?.version,
                applicationIcon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.orange,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
