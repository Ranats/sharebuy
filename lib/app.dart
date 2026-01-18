import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sharebuy/core/theme/theme_provider.dart';
import 'core/theme/app_theme.dart';
import 'core/router/app_router.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final skinAsync = ref.watch(appThemeSelectorProvider);

    return skinAsync.when(
      data: (skin) => MaterialApp.router(
        title: 'うちメモ | ShareBuy',
        theme: AppTheme.light(skin),
        darkTheme: AppTheme.dark(skin),
        themeMode: ThemeMode.system, // Or watch specific ThemeMode provider
        routerConfig: router,
      ),
      loading: () => const MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
      error: (e, _) => MaterialApp(
        home: Scaffold(body: Center(child: Text('Error initialization: $e'))),
      ),
    );
  }
}
