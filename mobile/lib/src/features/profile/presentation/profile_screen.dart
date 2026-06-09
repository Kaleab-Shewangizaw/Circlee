import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../theme/design_tokens.dart';
import '../../shared/data/social_graph_demo_data.dart';
import '../../shared/widgets/glass_panel.dart';
import '../../shared/widgets/glow_pill.dart';
import '../../shared/widgets/reveal.dart';
import '../../shared/widgets/section_heading.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final activeCircles = demoCircles.take(3).toList();
    final pastCircles = demoCircles.skip(3).take(2).toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
      children: [
        const Reveal(child: _ProfileHero()),
        const SizedBox(height: CircleeSpacing.xxxl),
        const Reveal(
          delay: Duration(milliseconds: 100),
          child: SectionHeading(
            eyebrow: 'Vibe board',
            title: 'Your personality in color',
          ),
        ),
        const SizedBox(height: CircleeSpacing.lg),
        const Reveal(
          delay: Duration(milliseconds: 160),
          child: _VibeBoard(),
        ),
        const SizedBox(height: CircleeSpacing.xxxl),
        const Reveal(
          delay: Duration(milliseconds: 220),
          child: SectionHeading(
            eyebrow: 'Active circles',
            title: 'What your social world looks like right now',
          ),
        ),
        const SizedBox(height: CircleeSpacing.lg),
        for (var index = 0; index < activeCircles.length; index++) ...[
          Reveal(
            delay: Duration(milliseconds: 260 + (index * 70)),
            child: _ProfileCircleCard(circle: activeCircles[index]),
          ),
          if (index != activeCircles.length - 1) const SizedBox(height: 14),
        ],
        const SizedBox(height: CircleeSpacing.xxxl),
        const Reveal(
          delay: Duration(milliseconds: 420),
          child: SectionHeading(
            eyebrow: 'Past circles',
            title: 'Memories that still shape your profile',
          ),
        ),
        const SizedBox(height: CircleeSpacing.lg),
        Reveal(
          delay: const Duration(milliseconds: 480),
          child: Row(
            children: [
              for (var index = 0; index < pastCircles.length; index++) ...[
                Expanded(child: _PastCircleTile(circle: pastCircles[index])),
                if (index != pastCircles.length - 1) const SizedBox(width: 14),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _ProfileHero extends StatelessWidget {
  const _ProfileHero();

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      color: CircleeFills.gold,
      glowColor: CircleeColors.accentGold,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 82,
                height: 82,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.14),
                  border: Border.all(color: Colors.white.withOpacity(0.18)),
                ),
                child: Text(
                  'K',
                  style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 18),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Kaleab', style: Theme.of(context).textTheme.headlineMedium),
                    const SizedBox(height: 8),
                    Text(
                      'Down for plans this weekend 🟢',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: CircleeColors.accentIce,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const GlowPill(
                      label: '12 people in your circle',
                      color: CircleeColors.accentMint,
                      icon: Icons.group_rounded,
                      filled: true,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: CircleeSpacing.xxl),
          Text(
            'Builder, anime fan, rooftop conversationalist, and the person who somehow turns “maybe” plans into real nights out.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

class _VibeBoard extends StatelessWidget {
  const _VibeBoard();

  @override
  Widget build(BuildContext context) {
    const tags = [
      ('anime', categoryAnime),
      ('late-night city', categoryMusic),
      ('deep talks', categoryFood),
      ('travel dreams', categoryTravel),
      ('study sprints', categoryStudy),
      ('morning reset', categoryFitness),
    ];

    return GlassPanel(
      glowColor: CircleeColors.accentSky,
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          for (final tag in tags)
            GlowPill(
              label: tag.$1,
              color: tag.$2.color,
              filled: true,
            ),
        ],
      ),
    );
  }
}

class _ProfileCircleCard extends StatelessWidget {
  const _ProfileCircleCard({required this.circle});

  final CirclePreview circle;

  @override
  Widget build(BuildContext context) {
    final category = categoryById(circle.categoryId);

    return GlassPanel(
      glowColor: category.color,
      child: InkWell(
        onTap: () => context.push('/circle/${circle.id}'),
        borderRadius: BorderRadius.circular(CircleeRadius.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                GlowPill(
                  label: category.label,
                  color: category.color,
                  icon: category.icon,
                  filled: true,
                ),
                const Spacer(),
                Text(
                  circle.vibeTag,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: category.color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: CircleeSpacing.xl),
            Text(circle.title, style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 10),
            Text(circle.description, style: Theme.of(context).textTheme.bodyLarge),
            const SizedBox(height: CircleeSpacing.lg),
            Text(
              circle.locationHint,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

class _PastCircleTile extends StatelessWidget {
  const _PastCircleTile({required this.circle});

  final CirclePreview circle;

  @override
  Widget build(BuildContext context) {
    final category = categoryById(circle.categoryId);

    return GlassPanel(
      color: category.surfaceColor,
      glowColor: category.color,
      padding: const EdgeInsets.all(CircleeSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(category.icon, color: Colors.white),
          const SizedBox(height: 18),
          Text(
            circle.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Still part of how people read your vibe.',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: CircleeColors.accentIce,
            ),
          ),
        ],
      ),
    );
  }
}
