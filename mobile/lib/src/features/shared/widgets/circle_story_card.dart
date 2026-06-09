import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../theme/design_tokens.dart';
import '../data/social_graph_demo_data.dart';
import 'active_avatar_cluster.dart';
import 'glass_panel.dart';
import 'glow_pill.dart';
import 'pulse_badge.dart';

class CircleStoryCard extends StatelessWidget {
  const CircleStoryCard({
    required this.circle,
    this.featured = false,
    super.key,
  });

  final CirclePreview circle;
  final bool featured;

  @override
  Widget build(BuildContext context) {
    final category = categoryById(circle.categoryId);

    return GlassPanel(
      color: featured ? category.surfaceColor : null,
      glowColor: category.color,
      padding: const EdgeInsets.all(CircleeSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (circle.isHot)
                PulseBadge(
                  label: 'Hot Circle',
                  color: category.color,
                )
              else
                GlowPill(
                  label: category.label,
                  color: category.color,
                  icon: category.icon,
                  filled: true,
                ),
              const Spacer(),
              Text(
                circle.locationHint,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: featured ? CircleeColors.accentIce : category.color,
                ),
              ),
            ],
          ),
          const SizedBox(height: CircleeSpacing.xl),
          Text(
            circle.title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            circle.description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: featured ? CircleeColors.accentIce : CircleeColors.textPrimary,
            ),
          ),
          const SizedBox(height: CircleeSpacing.lg),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              GlowPill(label: circle.mood, color: category.color),
              GlowPill(label: circle.vibeTag, color: category.color),
            ],
          ),
          const SizedBox(height: CircleeSpacing.xl),
          Row(
            children: [
              ActiveAvatarCluster(
                initials: circle.joinerInitials,
                ringColor: category.color,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  '${circle.joinerNames.length}+ people are already in',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: featured ? CircleeColors.accentIce : CircleeColors.textSecondary,
                  ),
                ),
              ),
              FilledButton(
                onPressed: () => context.push('/circle/${circle.id}'),
                style: FilledButton.styleFrom(
                  backgroundColor: category.color,
                  foregroundColor: CircleeColors.bgBase,
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
                ),
                child: const Text('Join'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
