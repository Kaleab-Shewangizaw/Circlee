import 'package:flutter/material.dart';

import '../../../theme/design_tokens.dart';
import '../../shared/widgets/glass_panel.dart';
import '../../shared/widgets/reveal.dart';
import '../../shared/widgets/section_heading.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
      children: const [
        Reveal(child: _DiscoverHeader()),
        SizedBox(height: CircleeSpacing.xl),
        Reveal(
          delay: Duration(milliseconds: 90),
          child: _SearchRow(),
        ),
        SizedBox(height: CircleeSpacing.xl),
        Reveal(
          delay: Duration(milliseconds: 150),
          child: _FilterRail(),
        ),
        SizedBox(height: CircleeSpacing.xxxl),
        Reveal(
          delay: Duration(milliseconds: 210),
          child: SectionHeading(
            eyebrow: 'Best matches',
            title: 'People and circles that already make sense',
          ),
        ),
        SizedBox(height: CircleeSpacing.lg),
        Reveal(
          delay: Duration(milliseconds: 270),
          child: _RecommendationStack(),
        ),
        SizedBox(height: CircleeSpacing.xxxl),
        Reveal(
          delay: Duration(milliseconds: 330),
          child: SectionHeading(
            eyebrow: 'Tonight nearby',
            title: 'Low-friction plans worth leaving the house for',
          ),
        ),
        SizedBox(height: CircleeSpacing.lg),
        Reveal(
          delay: Duration(milliseconds: 390),
          child: _EventIdeas(),
        ),
      ],
    );
  }
}

class _DiscoverHeader extends StatelessWidget {
  const _DiscoverHeader();

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      color: CircleeFills.social,
      glowColor: CircleeColors.accentCoral,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _HeaderLabel(
            icon: Icons.explore_rounded,
            text: 'Curated for your current vibe',
          ),
          const SizedBox(height: CircleeSpacing.xxl),
          Text(
            'Discover shouldn’t feel like a slot machine.',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: CircleeSpacing.md),
          Text(
            'Circlee ranks for intent, timing, social energy, and actual community health so the next tap feels more personal.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: CircleeColors.accentIce,
            ),
          ),
        ],
      ),
    );
  }
}

class _SearchRow extends StatelessWidget {
  const _SearchRow();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GlassPanel(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
            child: Row(
              children: [
                const Icon(
                  Icons.search_rounded,
                  color: CircleeColors.textMuted,
                ),
                const SizedBox(width: 12),
                Text(
                  'anime, founders, study sprint...',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        GlassPanel(
          padding: const EdgeInsets.all(16),
          glowColor: CircleeColors.accentSky,
          child: const Icon(Icons.tune_rounded, color: Colors.white),
        ),
      ],
    );
  }
}

class _FilterRail extends StatelessWidget {
  const _FilterRail();

  @override
  Widget build(BuildContext context) {
    const filters = [
      ('Tonight', CircleeColors.accentMint),
      ('Nearby', CircleeColors.accentSky),
      ('Campus', CircleeColors.accentGold),
      ('Low pressure', CircleeColors.accentCoral),
      ('Creative', CircleeColors.accentRose),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final filter in filters) ...[
            _FilterChip(label: filter.$1, color: filter.$2),
            const SizedBox(width: 10),
          ],
        ],
      ),
    );
  }
}

class _RecommendationStack extends StatelessWidget {
  const _RecommendationStack();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _RecommendationCard(
          title: 'Builders After Class',
          subtitle: '84% fit · Mutual goals: ship faster, build together',
          score: '84%',
          accent: CircleeColors.accentSky,
          description: 'High overlap in ambition, nighttime schedule, and consistency. The group is active without feeling chaotic.',
        ),
        SizedBox(height: 16),
        _RecommendationCard(
          title: 'Mika + Zara + Yusuf',
          subtitle: 'People match · Shared anime, creator energy, same campus',
          score: '91%',
          accent: CircleeColors.accentMint,
          description: 'This trio overlaps with your taste and already moves between the same two circles you keep returning to.',
        ),
      ],
    );
  }
}

class _RecommendationCard extends StatelessWidget {
  const _RecommendationCard({
    required this.title,
    required this.subtitle,
    required this.score,
    required this.accent,
    required this.description,
  });

  final String title;
  final String subtitle;
  final String score;
  final Color accent;
  final String description;

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      glowColor: accent,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(title, style: Theme.of(context).textTheme.titleLarge),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: accent.withOpacity(0.14),
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Text(
                  score,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: accent,
            ),
          ),
          const SizedBox(height: CircleeSpacing.lg),
          Text(description, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: CircleeSpacing.xl),
          Row(
            children: [
              FilledButton(
                onPressed: () {},
                child: const Text('Open match'),
              ),
              const SizedBox(width: 10),
              OutlinedButton(
                onPressed: () {},
                child: const Text('Save'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _EventIdeas extends StatelessWidget {
  const _EventIdeas();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _MiniEventCard(
          title: 'Moonlight study sprint',
          meta: 'Starts in 45 min · Library annex',
          accent: CircleeColors.accentGold,
        ),
        SizedBox(height: 14),
        _MiniEventCard(
          title: 'Street ramen + startup talk',
          meta: '7 people going · 0.8 mi away',
          accent: CircleeColors.accentCoral,
        ),
      ],
    );
  }
}

class _MiniEventCard extends StatelessWidget {
  const _MiniEventCard({
    required this.title,
    required this.meta,
    required this.accent,
  });

  final String title;
  final String meta;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      glowColor: accent,
      padding: const EdgeInsets.all(CircleeSpacing.xl),
      child: Row(
        children: [
          Container(
            width: 54,
            height: 54,
            decoration: BoxDecoration(
              color: accent.withOpacity(0.18),
              borderRadius: BorderRadius.circular(CircleeRadius.md),
            ),
            child: Icon(Icons.event_available_rounded, color: accent),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 6),
                Text(meta, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: Colors.white70),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
    required this.label,
    required this.color,
  });

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: color.withOpacity(0.24)),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: Colors.white,
          fontSize: 13,
        ),
      ),
    );
  }
}

class _HeaderLabel extends StatelessWidget {
  const _HeaderLabel({
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.16),
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: Colors.white.withOpacity(0.12)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: CircleeColors.accentGold),
          const SizedBox(width: 8),
          Text(
            text,
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
