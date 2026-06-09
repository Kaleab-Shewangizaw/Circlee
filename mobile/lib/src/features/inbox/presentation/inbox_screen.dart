import 'package:flutter/material.dart';

import '../../../theme/design_tokens.dart';
import '../../shared/widgets/glass_panel.dart';
import '../../shared/widgets/reveal.dart';
import '../../shared/widgets/section_heading.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
      children: const [
        Reveal(child: _InboxHero()),
        SizedBox(height: CircleeSpacing.xxl),
        Reveal(
          delay: Duration(milliseconds: 100),
          child: _SegmentRow(),
        ),
        SizedBox(height: CircleeSpacing.xxxl),
        Reveal(
          delay: Duration(milliseconds: 160),
          child: SectionHeading(
            eyebrow: 'Priority',
            title: 'Conversations that still feel warm',
          ),
        ),
        SizedBox(height: CircleeSpacing.lg),
        Reveal(
          delay: Duration(milliseconds: 220),
          child: _ConversationList(),
        ),
      ],
    );
  }
}

class _InboxHero extends StatelessWidget {
  const _InboxHero();

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      color: CircleeFills.aurora,
      glowColor: CircleeColors.accentSky,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('Inbox', style: Theme.of(context).textTheme.headlineLarge),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(99),
                ),
                child: Text(
                  '12 unread',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: CircleeSpacing.md),
          Text(
            'Your circles are moving. The best conversations are still easy to re-enter.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: CircleeColors.accentIce,
            ),
          ),
          const SizedBox(height: CircleeSpacing.xxl),
          const _PinnedRoomCard(),
        ],
      ),
    );
  }
}

class _PinnedRoomCard extends StatelessWidget {
  const _PinnedRoomCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(CircleeSpacing.lg),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.16),
        borderRadius: BorderRadius.circular(CircleeRadius.lg),
        border: Border.all(color: Colors.white.withOpacity(0.10)),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: CircleeColors.accentMint.withOpacity(0.16),
              borderRadius: BorderRadius.circular(CircleeRadius.md),
            ),
            child: const Icon(Icons.mic_rounded, color: CircleeColors.accentMint),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Live room: Startup Circle',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 6),
                Text(
                  '19 listening now · speaker queue open',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: CircleeColors.accentIce,
                  ),
                ),
              ],
            ),
          ),
          FilledButton(
            onPressed: () {},
            child: const Text('Join'),
          ),
        ],
      ),
    );
  }
}

class _SegmentRow extends StatelessWidget {
  const _SegmentRow();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: _SegmentChip(
            label: 'Priority',
            selected: true,
            tone: CircleeColors.accentSky,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _SegmentChip(
            label: 'Circles',
            selected: false,
            tone: CircleeColors.accentMint,
          ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: _SegmentChip(
            label: 'Events',
            selected: false,
            tone: CircleeColors.accentCoral,
          ),
        ),
      ],
    );
  }
}

class _SegmentChip extends StatelessWidget {
  const _SegmentChip({
    required this.label,
    required this.selected,
    required this.tone,
  });

  final String label;
  final bool selected;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeOutCubic,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: selected ? CircleeFills.aurora : CircleeColors.surfaceSecondary,
        borderRadius: BorderRadius.circular(CircleeRadius.lg),
        border: Border.all(
          color: selected ? CircleeColors.strokeStrong : CircleeColors.strokeSoft,
        ),
      ),
      child: Center(
        child: Text(
          label,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color: selected ? Colors.white : tone,
          ),
        ),
      ),
    );
  }
}

class _ConversationList extends StatelessWidget {
  const _ConversationList();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        _ConversationCard(
          title: 'Late Night Builders',
          preview: 'Anyone free for a 45 minute sprint before the demo?',
          stamp: '2m',
          tone: CircleeColors.accentSky,
          unreadCount: 8,
          meta: '48 live now',
        ),
        SizedBox(height: 14),
        _ConversationCard(
          title: 'Mika',
          preview: 'Locking the episode order. You in for the watch party?',
          stamp: '9m',
          tone: CircleeColors.accentCoral,
          unreadCount: 2,
          meta: 'Direct message',
        ),
        SizedBox(height: 14),
        _ConversationCard(
          title: '6AM Accountability',
          preview: 'Tomorrow check-in is pinned. Drop your target before sleep.',
          stamp: '21m',
          tone: CircleeColors.accentMint,
          unreadCount: 0,
          meta: '12 day streak',
        ),
      ],
    );
  }
}

class _ConversationCard extends StatelessWidget {
  const _ConversationCard({
    required this.title,
    required this.preview,
    required this.stamp,
    required this.tone,
    required this.unreadCount,
    required this.meta,
  });

  final String title;
  final String preview;
  final String stamp;
  final Color tone;
  final int unreadCount;
  final String meta;

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      glowColor: tone,
      padding: const EdgeInsets.all(CircleeSpacing.xl),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 54,
            height: 54,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: tone.withOpacity(0.22),
              borderRadius: BorderRadius.circular(CircleeRadius.md),
            ),
            child: Text(
              title.substring(0, 1),
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    Text(
                      stamp,
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        color: tone,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  meta,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: tone,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  preview,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
          if (unreadCount > 0) ...[
            const SizedBox(width: 12),
            Container(
              width: 28,
              height: 28,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: tone,
                shape: BoxShape.circle,
              ),
              child: Text(
                '$unreadCount',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: CircleeColors.bgBase,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
