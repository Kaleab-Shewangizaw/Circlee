import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'design_tokens.dart';

class AppTheme {
  static ThemeData get darkTheme {
    final baseTheme = ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
    );

    final scheme = ColorScheme(
      brightness: Brightness.dark,
      primary: CircleeColors.accentSky,
      onPrimary: CircleeColors.bgBase,
      secondary: CircleeColors.accentMint,
      onSecondary: CircleeColors.bgBase,
      error: CircleeColors.statusError,
      onError: Colors.white,
      surface: CircleeColors.surfacePrimary,
      onSurface: CircleeColors.textPrimary,
      primaryContainer: CircleeColors.bgElevated,
      onPrimaryContainer: CircleeColors.textPrimary,
      secondaryContainer: CircleeColors.surfaceGlass,
      onSecondaryContainer: CircleeColors.textPrimary,
      tertiary: CircleeColors.accentCoral,
      onTertiary: CircleeColors.bgBase,
      tertiaryContainer: CircleeColors.bgElevated,
      onTertiaryContainer: CircleeColors.textPrimary,
      surfaceContainerHighest: CircleeColors.surfaceTertiary,
      onSurfaceVariant: CircleeColors.textSecondary,
      outline: CircleeColors.strokeMedium,
      outlineVariant: CircleeColors.strokeSoft,
      shadow: CircleeColors.shadow,
      scrim: Colors.black54,
      inverseSurface: CircleeColors.accentIce,
      onInverseSurface: CircleeColors.bgBase,
      inversePrimary: CircleeColors.accentMint,
    );

    final bodyTextTheme = GoogleFonts.manropeTextTheme(baseTheme.textTheme).copyWith(
      headlineLarge: GoogleFonts.spaceGrotesk(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        height: 1.02,
        color: CircleeColors.textPrimary,
      ),
      headlineMedium: GoogleFonts.spaceGrotesk(
        fontSize: 24,
        fontWeight: FontWeight.w700,
        height: 1.08,
        color: CircleeColors.textPrimary,
      ),
      titleLarge: GoogleFonts.spaceGrotesk(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        height: 1.15,
        color: CircleeColors.textPrimary,
      ),
      titleMedium: GoogleFonts.manrope(
        fontSize: 15,
        fontWeight: FontWeight.w700,
        height: 1.2,
        color: CircleeColors.textPrimary,
      ),
      bodyLarge: GoogleFonts.manrope(
        fontSize: 15,
        height: 1.35,
        fontWeight: FontWeight.w600,
        color: CircleeColors.textPrimary,
      ),
      bodyMedium: GoogleFonts.manrope(
        fontSize: 13,
        height: 1.38,
        fontWeight: FontWeight.w500,
        color: CircleeColors.textSecondary,
      ),
      labelLarge: GoogleFonts.manrope(
        fontSize: 13,
        fontWeight: FontWeight.w700,
        color: CircleeColors.textPrimary,
      ),
      labelMedium: GoogleFonts.ibmPlexMono(
        fontSize: 11,
        letterSpacing: 0.3,
        fontWeight: FontWeight.w500,
        color: CircleeColors.textMuted,
      ),
    );

    return baseTheme.copyWith(
      colorScheme: scheme,
      scaffoldBackgroundColor: Colors.transparent,
      textTheme: bodyTextTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: bodyTextTheme.headlineMedium,
      ),
      cardTheme: const CardThemeData(
        color: Colors.transparent,
        margin: EdgeInsets.zero,
        elevation: 0,
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          foregroundColor: CircleeColors.bgBase,
          backgroundColor: CircleeColors.accentSky,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(CircleeRadius.lg),
          ),
          textStyle: bodyTextTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: CircleeColors.textPrimary,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          side: const BorderSide(color: CircleeColors.strokeMedium),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(CircleeRadius.lg),
          ),
          textStyle: bodyTextTheme.labelLarge,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: CircleeColors.surfaceSecondary,
        hintStyle: bodyTextTheme.bodyMedium?.copyWith(color: CircleeColors.textMuted),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(CircleeRadius.lg),
          borderSide: const BorderSide(color: CircleeColors.strokeSoft),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(CircleeRadius.lg),
          borderSide: const BorderSide(color: CircleeColors.strokeSoft),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(CircleeRadius.lg),
          borderSide: const BorderSide(color: CircleeColors.accentSky),
        ),
      ),
      chipTheme: baseTheme.chipTheme.copyWith(
        backgroundColor: CircleeColors.surfaceSecondary,
        side: const BorderSide(color: CircleeColors.strokeSoft),
        labelStyle: bodyTextTheme.labelLarge?.copyWith(fontSize: 13),
        selectedColor: CircleeColors.surfaceTertiary,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      ),
    );
  }
}
