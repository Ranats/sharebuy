import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_provider.g.dart';

@riverpod
class ThemeController extends _$ThemeController {
  static const _keyParams = 'saved_theme_mode';

  @override
  FutureOr<ThemeMode> build() async {
    final prefs = await SharedPreferences.getInstance();
    final savedMode = prefs.getString(_keyParams);
    if (savedMode == 'light') return ThemeMode.light;
    if (savedMode == 'dark') return ThemeMode.dark;
    // We can also save 'popup'/'smart' choice here if we want to toggle skin type
    // But ThemeMode is just Light/Dark/System.
    // For Skin switching (Smart vs Pop), we need another state.
    // Let's assume we want to switch between Skin Types.
    return ThemeMode.system;
  }
}

// Skin Type Provider
@riverpod
class AppThemeSelector extends _$AppThemeSelector {
  static const _keySkin = 'saved_skin_type';

  @override
  FutureOr<String> build() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keySkin) ?? 'smart';
  }

  Future<void> setSkin(String skin) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_keySkin, skin);
      return skin;
    });
  }
}
