// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(ThemeController)
final themeControllerProvider = ThemeControllerProvider._();

final class ThemeControllerProvider
    extends $AsyncNotifierProvider<ThemeController, ThemeMode> {
  ThemeControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'themeControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$themeControllerHash();

  @$internal
  @override
  ThemeController create() => ThemeController();
}

String _$themeControllerHash() => r'69b37d0c58ba0a44f0bd43d0e11ace27cdb2ff8f';

abstract class _$ThemeController extends $AsyncNotifier<ThemeMode> {
  FutureOr<ThemeMode> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<ThemeMode>, ThemeMode>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<ThemeMode>, ThemeMode>,
              AsyncValue<ThemeMode>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(AppThemeSelector)
final appThemeSelectorProvider = AppThemeSelectorProvider._();

final class AppThemeSelectorProvider
    extends $AsyncNotifierProvider<AppThemeSelector, String> {
  AppThemeSelectorProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appThemeSelectorProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appThemeSelectorHash();

  @$internal
  @override
  AppThemeSelector create() => AppThemeSelector();
}

String _$appThemeSelectorHash() => r'ecf2ab951b8e89c94a1aaa365baa951e0c019b00';

abstract class _$AppThemeSelector extends $AsyncNotifier<String> {
  FutureOr<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<String>, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<String>, String>,
              AsyncValue<String>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
