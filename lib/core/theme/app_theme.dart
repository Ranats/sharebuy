import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// 拡張テーマ定義: 色
@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({required this.surfaceVariant, required this.customAccent});

  final Color surfaceVariant;
  final Color customAccent;

  @override
  AppColors copyWith({Color? surfaceVariant, Color? customAccent}) {
    return AppColors(
      surfaceVariant: surfaceVariant ?? this.surfaceVariant,
      customAccent: customAccent ?? this.customAccent,
    );
  }

  @override
  AppColors lerp(ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;
    return AppColors(
      surfaceVariant: Color.lerp(surfaceVariant, other.surfaceVariant, t)!,
      customAccent: Color.lerp(customAccent, other.customAccent, t)!,
    );
  }
}

// 拡張テーマ定義: 寸法・形状
@immutable
class AppDimens extends ThemeExtension<AppDimens> {
  const AppDimens({
    required this.radius,
    required this.cardPadding,
    required this.pagePadding,
    required this.itemSpacing,
  });

  final double radius;
  final double cardPadding;
  final double pagePadding;
  final double itemSpacing;

  @override
  AppDimens copyWith({
    double? radius,
    double? cardPadding,
    double? pagePadding,
    double? itemSpacing,
  }) {
    return AppDimens(
      radius: radius ?? this.radius,
      cardPadding: cardPadding ?? this.cardPadding,
      pagePadding: pagePadding ?? this.pagePadding,
      itemSpacing: itemSpacing ?? this.itemSpacing,
    );
  }

  @override
  AppDimens lerp(ThemeExtension<AppDimens>? other, double t) {
    if (other is! AppDimens) return this;
    return AppDimens(
      radius: (lerpDouble(radius, other.radius, t) ?? radius),
      cardPadding:
          (lerpDouble(cardPadding, other.cardPadding, t) ?? cardPadding),
      pagePadding:
          (lerpDouble(pagePadding, other.pagePadding, t) ?? pagePadding),
      itemSpacing:
          (lerpDouble(itemSpacing, other.itemSpacing, t) ?? itemSpacing),
    );
  }
}

class AppTheme {
  static ThemeData light(String skin) {
    if (skin == 'pop') return _pop;
    return _smart;
  }

  static ThemeData dark(String skin) {
    if (skin == 'pop') return _pop;
    return _smart;
  }

  // --- SMART THEME (Default) ---
  static final ThemeData _smart = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFF007AFF),
      primary: const Color(0xFF1A1A1A),
      background: const Color(0xFFF8F9FA),
      surface: Colors.white,
    ),
    textTheme: GoogleFonts.interTextTheme(),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Color(0xFF1A1A1A),
      elevation: 0,
      centerTitle: false,
    ),
    cardTheme: const CardThemeData(
      elevation: 0,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: Color(0xFFEEEEEE)),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
    ),
    extensions: const <ThemeExtension>[
      AppColors(
        surfaceVariant: Color(0xFFF0F0F0),
        customAccent: Color(0xFF007AFF),
      ),
      AppDimens(
        radius: 8.0,
        cardPadding: 16.0,
        pagePadding: 20.0,
        itemSpacing: 12.0,
      ),
    ],
  );

  // --- POP THEME ---
  static final ThemeData _pop = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFFF6B6B),
      primary: const Color(0xFFFF6B6B),
      background: const Color(0xFFFFF9F0),
      surface: Colors.white,
    ),
    textTheme: GoogleFonts.mPlusRounded1cTextTheme(),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFFF6B6B),
      foregroundColor: Colors.white,
      elevation: 0,
      centerTitle: true,
    ),
    cardTheme: const CardThemeData(
      elevation: 2,
      shadowColor: Color(0x33FF6B6B),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF4ECDC4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
    extensions: const <ThemeExtension>[
      AppColors(
        surfaceVariant: Color(0xFFFFE3E3),
        customAccent: Color(0xFF4ECDC4),
      ),
      AppDimens(
        radius: 20.0,
        cardPadding: 20.0,
        pagePadding: 24.0,
        itemSpacing: 16.0,
      ),
    ],
  );
}
