import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../theme/design_tokens.dart';
import '../../shared/data/social_graph_demo_data.dart';
import '../../shared/widgets/glass_panel.dart';
import '../../shared/widgets/glow_pill.dart';
import '../../shared/widgets/pulse_badge.dart';
import '../../shared/widgets/reveal.dart';
import '../../shared/widgets/scene_scaffold.dart';

class CircleDetailScreen extends StatelessWidget {
  const CircleDetailScreen({
    required this.circleId,
    super.key,
  });

  final String circleId;

  @override
  Widget build(BuildContext context) {
    final circle = circleById(circleId);
    final category = categoryById(circle.categoryId);

    return SceneScaffold(
      bottomBar: Padding(
        padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
        child: SafeArea(
          top: false,
          child: GlassPanel(
            glowColor: category.color,
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${circle.liveCount} people feeling this one',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: category.color,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Join the Circle',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                ),
                FilledButton(
                  onPressed: () {},
                  style: FilledButton.styleFrom(
                    backgroundColor: category.color,
                    foregroundColor: CircleeColors.bgBase,
                  ),
                  child: const Text('Join the Circle'),
                ),
              ],
            ),
          ),
        ),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: ColoredBox(
              color: category.color.withOpacity(0.10),
            ),
          ),
          Positioned(
            top: -40,
            right: -20,
            child: ImageFiltered(
              imageFilter: ImageFilter.blur(sigmaX: 60, sigmaY: 60),
              child: Container(
                width: 220,
                height: 220,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: category.color.withOpacity(0.18),
                ),
              ),
            ),
          ),
          ListView(
            padding: const EdgeInsets.fromLTRB(24, 18, 24, 160),
            children: [
              Reveal(
                child: Row(
                  children: [
                    _TopIconButton(
                      icon: Icons.arrow_back_ios_new_rounded,
                      onTap: () => context.pop(),
                    ),
                    const Spacer(),
                    PulseBadge(label: 'Live pulse', color: category.color),
                    const Spacer(),
                    _TopIconButton(
                      icon: Icons.ios_share_rounded,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
              const SizedBox(height: CircleeSpacing.xxxl),
              Reveal(
                delay: const Duration(milliseconds: 100),
                child: GlowPill(
                  label: 'Hosted by ${circle.organizer}',
                  color: category.color,
                  icon: category.icon,
                  filled: true,
                ),
              ),
              const SizedBox(height: CircleeSpacing.xxl),
              Reveal(
                delay: const Duration(milliseconds: 160),
                child: Text(
                  circle.title,
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Reveal(
                delay: const Duration(milliseconds: 220),
                child: Text(
                  '${circle.locationHint} · ${circle.vibeTag}',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: category.color,
                  ),
                ),
              ),
              const SizedBox(height: CircleeSpacing.xxl),
              Reveal(
                delay: const Duration(milliseconds: 280),
                child: GlassPanel(
                  color: category.surfaceColor,
                  glowColor: category.color,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'The vibe',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: CircleeColors.accentIce,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        circle.description,
                        style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: CircleeSpacing.xxxl),
              Reveal(
                delay: const Duration(milliseconds: 340),
                child: Text(
                  'People stepping in',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: CircleeSpacing.lg),
              Reveal(
                delay: const Duration(milliseconds: 400),
                child: SizedBox(
                  height: 102,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: circle.joinerNames.length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      return _JoinerChip(
                        initials: circle.joinerInitials[index],
                        name: circle.joinerNames[index],
                        color: category.color,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: CircleeSpacing.xxxl),
              Reveal(
                delay: const Duration(milliseconds: 460),
                child: Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: [
                    for (final tag in circle.tags)
                      GlowPill(
                        label: tag,
                        color: category.color,
                      ),
                  ],
                ),
              ),
              const SizedBox(height: CircleeSpacing.xxxl),
              Reveal(
                delay: const Duration(milliseconds: 520),
                child: GlassPanel(
                  glowColor: category.color,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Recent energy',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: category.color,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Container(
                        padding: const EdgeInsets.all(CircleeSpacing.lg),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.18),
                          borderRadius: BorderRadius.circular(CircleeRadius.lg),
                          border: Border.all(color: Colors.white.withOpacity(0.10)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 34,
                              height: 34,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: category.color.withOpacity(0.16),
                                shape: BoxShape.circle,
                              ),
                              child: Text(
                                circle.organizer.substring(0, 1),
                                style: Theme.of(context).textTheme.labelLarge,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                circle.chatTeaser,
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TopIconButton extends StatelessWidget {
  const _TopIconButton({
    required this.icon,
    required this.onTap,
  });

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Ink(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          color: CircleeColors.surfaceGlass,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: CircleeColors.strokeSoft),
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}

class _JoinerChip extends StatelessWidget {
  const _JoinerChip({
    required this.initials,
    required this.name,
    required this.color,
  });

  final String initials;
  final String name;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 86,
      padding: const EdgeInsets.all(CircleeSpacing.md),
      decoration: BoxDecoration(
        color: CircleeColors.surfaceSecondary,
        borderRadius: BorderRadius.circular(CircleeRadius.lg),
        border: Border.all(color: CircleeColors.strokeSoft),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 42,
            height: 42,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withOpacity(0.16),
              border: Border.all(color: color.withOpacity(0.30)),
            ),
            child: Text(
              initials,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
