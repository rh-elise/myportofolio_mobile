import 'package:flutter/material.dart';

/// Token warna yang diambil langsung dari `static/css/style.css` website
/// portofolio agar tampilan mobile dan web konsisten.
abstract final class AppColors {
  static const ink = Color(0xFF151515);
  static const paper = Color(0xFFFFFFFF);
  static const accent = Color(0xFFEB1000);
  static const accentDark = Color(0xFF9B0A00);
  static const textMuted = Color(0xFF374151);
  static const hint = Color(0xFF9CA3AF);

  /// Garis pemisah tipis untuk tabel informasi di halaman utama.
  static const lineSoft = Color(0x26151515);
}

/// Tema minimalis: palet web, sudut tajam (`--radius: 0`), tanpa bayangan.
abstract final class AppTheme {
  static ThemeData get light {
    const sharp = RoundedRectangleBorder(borderRadius: BorderRadius.zero);

    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.light(
        primary: AppColors.accent,
        onPrimary: AppColors.paper,
        secondary: AppColors.ink,
        onSecondary: AppColors.paper,
        surface: AppColors.paper,
        onSurface: AppColors.ink,
        error: AppColors.accentDark,
        onError: AppColors.paper,
        outline: AppColors.ink,
      ),
      scaffoldBackgroundColor: AppColors.paper,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.ink,
        foregroundColor: AppColors.paper,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        titleTextStyle: TextStyle(
          color: AppColors.paper,
          fontSize: 18.0,
          fontWeight: FontWeight.w800,
          letterSpacing: 1.0,
        ),
      ),
      drawerTheme: const DrawerThemeData(
        backgroundColor: AppColors.paper,
        shape: sharp,
        elevation: 0,
      ),
      dividerTheme: const DividerThemeData(
        color: AppColors.lineSoft,
        thickness: 1.0,
        space: 1.0,
      ),
      inputDecorationTheme: InputDecorationThemeData(
        filled: true,
        fillColor: AppColors.paper,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14.0,
          vertical: 16.0,
        ),
        hintStyle: const TextStyle(
          color: AppColors.hint,
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
        ),
        border: _border(AppColors.ink),
        enabledBorder: _border(AppColors.ink),
        focusedBorder: _border(AppColors.accent),
        errorBorder: _border(AppColors.accent),
        focusedErrorBorder: _border(AppColors.accent),
        errorStyle: const TextStyle(
          color: AppColors.accentDark,
          fontSize: 12.5,
          fontWeight: FontWeight.w600,
        ),
        errorMaxLines: 2,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.ink,
          foregroundColor: AppColors.paper,
          disabledBackgroundColor: AppColors.textMuted,
          elevation: 0.0,
          padding: const EdgeInsets.symmetric(horizontal: 22.0, vertical: 16.0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
            side: BorderSide(color: AppColors.ink, width: 2.0),
          ),
          textStyle: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          backgroundColor: AppColors.paper,
          foregroundColor: AppColors.ink,
          elevation: 0.0,
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          side: const BorderSide(color: AppColors.ink, width: 2.0),
          shape: sharp,
          textStyle: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.ink,
          shape: sharp,
          textStyle: const TextStyle(
            fontSize: 14.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      cardTheme: const CardThemeData(
        color: AppColors.paper,
        surfaceTintColor: Colors.transparent,
        elevation: 0.0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: BorderSide(color: AppColors.ink, width: 2.0),
        ),
      ),
      dialogTheme: const DialogThemeData(
        backgroundColor: AppColors.paper,
        surfaceTintColor: Colors.transparent,
        elevation: 0.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: BorderSide(color: AppColors.ink, width: 2.0),
        ),
        titleTextStyle: TextStyle(
          color: AppColors.ink,
          fontSize: 18.0,
          fontWeight: FontWeight.w900,
        ),
        contentTextStyle: TextStyle(
          color: AppColors.textMuted,
          fontSize: 14.0,
          height: 1.5,
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.ink,
        contentTextStyle: const TextStyle(color: AppColors.paper),
        actionTextColor: AppColors.accent,
        behavior: SnackBarBehavior.floating,
        shape: sharp,
      ),
      listTileTheme: const ListTileThemeData(
        iconColor: AppColors.ink,
        textColor: AppColors.ink,
        shape: sharp,
      ),
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.accent,
      ),
    );
  }

  /// Garis tegas 2px tanpa lengkung, versi minimalis dari `.form-group input`.
  static OutlineInputBorder _border(Color color) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.zero,
      borderSide: BorderSide(color: color, width: 2.0),
    );
  }
}
