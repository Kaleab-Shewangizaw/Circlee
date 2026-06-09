import 'package:flutter/material.dart';

import '../../../theme/design_tokens.dart';

class AmbientBackground extends StatelessWidget {
  const AmbientBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(color: CircleeFills.appBackground),
      child: Stack(
        children: const [
          _Orb(
            size: 210,
            top: -40,
            left: -20,
            color: CircleeColors.accentSky,
            opacity: 0.08,
          ),
          _Orb(
            size: 190,
            top: 180,
            right: -60,
            color: CircleeColors.accentMint,
            opacity: 0.07,
          ),
          _Orb(
            size: 180,
            bottom: 140,
            left: -60,
            color: CircleeColors.accentRose,
            opacity: 0.05,
          ),
          _Orb(
            size: 150,
            bottom: 80,
            right: 0,
            color: CircleeColors.accentGold,
            opacity: 0.04,
          ),
        ],
      ),
    );
  }
}

class _Orb extends StatelessWidget {
  const _Orb({
    required this.size,
    required this.color,
    required this.opacity,
    this.top,
    this.right,
    this.bottom,
    this.left,
  });

  final double size;
  final Color color;
  final double opacity;
  final double? top;
  final double? right;
  final double? bottom;
  final double? left;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      right: right,
      bottom: bottom,
      left: left,
      child: IgnorePointer(
        child: Container(
          width: size * 0.56,
          height: size * 0.56,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(opacity),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(opacity),
                blurRadius: size * 0.34,
                spreadRadius: size * 0.05,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
