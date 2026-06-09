import 'package:flutter/material.dart';

import '../../../theme/design_tokens.dart';

class SectionHeading extends StatelessWidget {
  const SectionHeading({
    required this.eyebrow,
    required this.title,
    this.actionLabel,
    this.onActionTap,
    super.key,
  });

  final String eyebrow;
  final String title;
  final String? actionLabel;
  final VoidCallback? onActionTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                eyebrow.toUpperCase(),
                style: theme.labelMedium?.copyWith(
                  color: CircleeColors.accentMint,
                  letterSpacing: 1.1,
                ),
              ),
              const SizedBox(height: 6),
              Text(title, style: theme.headlineMedium),
            ],
          ),
        ),
        if (actionLabel != null)
          TextButton(
            onPressed: onActionTap,
            child: Text(actionLabel!),
          ),
      ],
    );
  }
}
