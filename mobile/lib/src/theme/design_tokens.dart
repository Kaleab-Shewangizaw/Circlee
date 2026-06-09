import 'package:flutter/material.dart';

class CircleeColors {
  static const bgBase = Color(0xFF06070D);
  static const bgTop = Color(0xFF0B0E17);
  static const bgBottom = Color(0xFF030409);
  static const bgElevated = Color(0xFF101525);
  static const surfacePrimary = Color(0xD8131826);
  static const surfaceSecondary = Color(0xCC0E1320);
  static const surfaceTertiary = Color(0xFF151C2D);
  static const surfaceGlass = Color(0xB0121522);
  static const strokeSoft = Color(0x14F3F7FF);
  static const strokeMedium = Color(0x2E72B8FF);
  static const strokeStrong = Color(0x40A77DFF);
  static const textPrimary = Color(0xFFF7F8FF);
  static const textSecondary = Color(0xFFAFB8D1);
  static const textMuted = Color(0xFF7A849E);
  static const accentSky = Color(0xFF57C7FF);
  static const accentMint = Color(0xFF8B62FF);
  static const accentCoral = Color(0xFF9A77FF);
  static const accentGold = Color(0xFFB4B7FF);
  static const accentRose = Color(0xFF7457FF);
  static const accentIce = Color(0xFFE9F2FF);
  static const statusSuccess = Color(0xFF57C7FF);
  static const statusWarn = Color(0xFF8B62FF);
  static const statusError = Color(0xFF9F7BFF);
  static const shadow = Color(0x80020510);
}

class CircleeFills {
  static const appBackground = CircleeColors.bgBase;
  static const hero = Color(0xFF12182A);
  static const aurora = Color(0xFF141B30);
  static const social = Color(0xFF161324);
  static const gold = Color(0xFF17182A);
}

class CircleeRadius {
  static const sm = 14.0;
  static const md = 18.0;
  static const lg = 22.0;
  static const xl = 26.0;
  static const xxl = 32.0;
}

class CircleeSpacing {
  static const xs = 4.0;
  static const sm = 8.0;
  static const md = 10.0;
  static const lg = 14.0;
  static const xl = 18.0;
  static const xxl = 22.0;
  static const xxxl = 28.0;
  static const jumbo = 36.0;
}

class CircleeShadows {
  static List<BoxShadow> panel([Color color = CircleeColors.shadow]) {
    return [
      BoxShadow(
        color: color.withOpacity(0.28),
        blurRadius: 24,
        offset: const Offset(0, 14),
      ),
    ];
  }

  static List<BoxShadow> glow(Color color) {
    return [
      BoxShadow(
        color: color.withOpacity(0.18),
        blurRadius: 28,
        spreadRadius: -10,
        offset: const Offset(0, 12),
      ),
    ];
  }
}
