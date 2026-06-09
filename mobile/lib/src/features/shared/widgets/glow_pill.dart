import 'package:flutter/material.dart';

import '../../../theme/design_tokens.dart';

class GlowPill extends StatelessWidget {
  const GlowPill({
    required this.label,
    this.color = CircleeColors.accentSky,
    this.icon,
    this.filled = false,
    super.key,
  });

  final String label;
  final Color color;
  final IconData? icon;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    final background = filled ? color.withOpacity(0.18) : Colors.black.withOpacity(0.14);
    final border = filled ? color.withOpacity(0.34) : Colors.white.withOpacity(0.10);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: border),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 15, color: color),
            const SizedBox(width: 8),
          ],
          Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Colors.white,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
