import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../theme/design_tokens.dart';
import '../../shared/data/social_graph_demo_data.dart';
import '../../shared/widgets/active_avatar_cluster.dart';
import '../../shared/widgets/glass_panel.dart';
import '../../shared/widgets/glow_pill.dart';
import '../../shared/widgets/reveal.dart';

class PeopleScreen extends HookWidget {
  const PeopleScreen({super.key});

  static const _tabs = ['Nearby', 'Similar Plans', 'New People', 'Mutuals'];

  @override
  Widget build(BuildContext context) {
    final selectedTab = useState('Nearby');
    final people = _peopleForTab(selectedTab.value);

    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
      children: [
        const Reveal(child: _PeopleHero()),
        const SizedBox(height: CircleeSpacing.xxl),
        Reveal(
          delay: const Duration(milliseconds: 100),
          child: _PeopleTabs(
            selectedTab: selectedTab.value,
            onSelected: (value) => selectedTab.value = value,
          ),
        ),
        const SizedBox(height: CircleeSpacing.xxl),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 320),
          switchInCurve: Curves.easeOutCubic,
          switchOutCurve: Curves.easeInCubic,
          child: GridView.builder(
            key: ValueKey(selectedTab.value),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: people.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 14,
              crossAxisSpacing: 14,
              childAspectRatio: 0.76,
            ),
            itemBuilder: (context, index) {
              return Reveal(
                delay: Duration(milliseconds: 180 + (index * 70)),
                child: _PersonCard(person: people[index]),
              );
            },
          ),
        ),
      ],
    );
  }

  List<PersonPreview> _peopleForTab(String tab) {
    switch (tab) {
      case 'Similar Plans':
        return demoPeople.where((person) => person.sharedCircleIds.length > 1).toList();
      case 'New People':
        return demoPeople.reversed.toList();
      case 'Mutuals':
        return demoPeople.where((person) => person.name != 'Mika').take(4).toList();
      case 'Nearby':
      default:
        return demoPeople;
    }
  }
}

class _PeopleHero extends StatelessWidget {
  const _PeopleHero();

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      color: CircleeFills.social,
      glowColor: CircleeColors.accentCoral,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const GlowPill(
            label: 'Connections that already make sense',
            color: CircleeColors.accentGold,
            icon: Icons.favorite_border_rounded,
            filled: true,
          ),
          const SizedBox(height: CircleeSpacing.xxl),
          Text(
            'Find your people, not profiles.',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: CircleeSpacing.md),
          Text(
            'Everyone here shares a plan, a mood, or a future trip with you. The app should feel like a warm introduction, not a sorting machine.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: CircleeColors.accentIce,
            ),
          ),
          const SizedBox(height: CircleeSpacing.xl),
          ActiveAvatarCluster(
            initials: const ['MI', 'NO', 'LE', 'YA', 'HE'],
            ringColor: CircleeColors.accentGold,
            size: 46,
          ),
        ],
      ),
    );
  }
}

class _PeopleTabs extends StatelessWidget {
  const _PeopleTabs({
    required this.selectedTab,
    required this.onSelected,
  });

  final String selectedTab;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final tab in PeopleScreen._tabs) ...[
            _TabPill(
              label: tab,
              selected: selectedTab == tab,
              onTap: () => onSelected(tab),
            ),
            const SizedBox(width: 10),
          ],
        ],
      ),
    );
  }
}

class _TabPill extends StatelessWidget {
  const _TabPill({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        color: selected ? CircleeFills.aurora : CircleeColors.surfaceSecondary,
        borderRadius: BorderRadius.circular(99),
        border: Border.all(
          color: selected ? CircleeColors.strokeStrong : CircleeColors.strokeSoft,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(99),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class _PersonCard extends StatelessWidget {
  const _PersonCard({required this.person});

  final PersonPreview person;

  @override
  Widget build(BuildContext context) {
    final category = categoryById(person.categoryId);

    return GlassPanel(
      glowColor: category.color,
      padding: const EdgeInsets.all(CircleeSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 54,
                height: 54,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: category.surfaceColor,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  person.initials,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
              const Spacer(),
              Icon(category.icon, color: category.color, size: 22),
            ],
          ),
          const SizedBox(height: 18),
          Text(person.name, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 8),
          Text(
            person.subtitle,
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: category.color,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            person.status,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          const Spacer(),
          GlowPill(
            label: '${person.sharedCircleIds.length} shared circles',
            color: category.color,
          ),
        ],
      ),
    );
  }
}
