import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../theme/design_tokens.dart';
import '../../shared/widgets/glass_panel.dart';
import '../../shared/widgets/glow_pill.dart';
import '../../shared/widgets/pulse_badge.dart';
import '../../shared/widgets/reveal.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  static const _filters = [
    'All',
    'Chill',
    'Active',
    'Creative',
    'Social',
  ];

  static const _posts = [
    _FeedPost(
      title: 'Late Night Rooftop Set',
      creator: 'Mika',
      caption: 'A tiny crowd, good sound, and the kind of plans that turn into stories.',
      location: 'Bole rooftop',
      mood: 'Social',
      likes: '3.4k',
      comments: '128',
      viewers: '2.1k',
      duration: '0:42',
      mediaHeight: 298,
    ),
    _FeedPost(
      title: 'Blue Hour Study Sprint',
      creator: 'Yara',
      caption: 'Quiet tables, warm tea, and enough momentum to finish one more chapter.',
      location: 'Library annex',
      mood: 'Chill',
      likes: '2.1k',
      comments: '64',
      viewers: '940',
      duration: '1:05',
      mediaHeight: 238,
    ),
    _FeedPost(
      title: 'Sunrise Run Crew',
      creator: 'Henok',
      caption: 'Someone always sets the pace, someone always brings coffee after.',
      location: 'Entoto trail',
      mood: 'Active',
      likes: '4.9k',
      comments: '211',
      viewers: '1.8k',
      duration: '0:58',
      mediaHeight: 338,
    ),
    _FeedPost(
      title: 'Vinyl After Dark',
      creator: 'Tino',
      caption: 'A room that gets softer every time the needle drops.',
      location: 'Piassa loft',
      mood: 'Creative',
      likes: '1.8k',
      comments: '49',
      viewers: '760',
      duration: '0:31',
      mediaHeight: 262,
    ),
    _FeedPost(
      title: 'Midnight Noodle Club',
      creator: 'Leah',
      caption: 'Food first. Chemistry after. No pressure, just a table worth joining.',
      location: 'Kazanchis',
      mood: 'Social',
      likes: '2.8k',
      comments: '93',
      viewers: '1.3k',
      duration: '1:14',
      mediaHeight: 286,
    ),
    _FeedPost(
      title: 'Movie Night on the Balcony',
      creator: 'Dani',
      caption: 'Big blankets, one projector, and everybody pretending not to cry.',
      location: 'Megenagna',
      mood: 'Chill',
      likes: '3.1k',
      comments: '72',
      viewers: '1.1k',
      duration: '0:26',
      mediaHeight: 244,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final selectedFilter = useState('All');
    final filtered = _posts
        .where((post) => selectedFilter.value == 'All' || post.mood == selectedFilter.value)
        .toList();
    final heroPost = filtered.isNotEmpty ? filtered.first : _posts.first;
    final masonryPosts = filtered.length > 1 ? filtered.skip(1).toList() : _posts.skip(1).toList();

    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: [
        const Reveal(child: _FeedHeader()),
        const SizedBox(height: 12),
        Reveal(
          delay: const Duration(milliseconds: 80),
          child: _FilterRail(
            selected: selectedFilter.value,
            onSelected: (value) => selectedFilter.value = value,
          ),
        ),
        const SizedBox(height: 14),
        Reveal(
          delay: const Duration(milliseconds: 140),
          child: _FeaturedPost(post: heroPost),
        ),
        const SizedBox(height: 14),
        Reveal(
          delay: const Duration(milliseconds: 200),
          child: _SectionHeader(
            title: 'Masonry feed',
            subtitle: '${masonryPosts.length} live picks',
          ),
        ),
        const SizedBox(height: 12),
        _MasonryFeed(posts: masonryPosts),
      ],
    );
  }
}

class _FeedHeader extends StatelessWidget {
  const _FeedHeader();

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      color: CircleeFills.hero,
      glowColor: CircleeColors.accentSky,
      padding: const EdgeInsets.all(18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const PulseBadge(
                label: '3 near you planning tonight',
                color: CircleeColors.accentSky,
              ),
              const Spacer(),
              _MiniAvatarRing(),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Hey Kaleab.',
            style: Theme.of(context).textTheme.headlineLarge,
          ),
          const SizedBox(height: 6),
          Text(
            'People, plans, and video moments that feel worth stepping into.',
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: CircleeColors.accentIce,
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterRail extends StatelessWidget {
  const _FilterRail({
    required this.selected,
    required this.onSelected,
  });

  final String selected;
  final ValueChanged<String> onSelected;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final filter in HomeScreen._filters) ...[
            _FilterChip(
              label: filter,
              selected: selected == filter,
              onTap: () => onSelected(filter),
            ),
            const SizedBox(width: 10),
          ],
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  const _FilterChip({
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
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      decoration: BoxDecoration(
        color: selected ? CircleeFills.aurora : CircleeColors.surfaceSecondary,
        borderRadius: BorderRadius.circular(99),
        border: Border.all(
          color: selected ? CircleeColors.accentSky.withOpacity(0.30) : CircleeColors.strokeSoft,
        ),
        boxShadow: selected ? CircleeShadows.glow(CircleeColors.accentSky) : null,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(99),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          child: Text(
            label,
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}

class _FeaturedPost extends StatelessWidget {
  const _FeaturedPost({required this.post});

  final _FeedPost post;

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      color: CircleeColors.surfacePrimary,
      glowColor: CircleeColors.accentSky,
      padding: EdgeInsets.zero,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _MediaFrame(post: post, hero: true),
          Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      post.title,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const Spacer(),
                    Text(
                      post.location,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  post.caption,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MasonryFeed extends StatelessWidget {
  const _MasonryFeed({required this.posts});

  final List<_FeedPost> posts;

  @override
  Widget build(BuildContext context) {
    final left = <_FeedPost>[];
    final right = <_FeedPost>[];
    double leftHeight = 0;
    double rightHeight = 0;

    for (final post in posts) {
      final estimatedHeight = post.mediaHeight + 104;
      if (leftHeight <= rightHeight) {
        left.add(post);
        leftHeight += estimatedHeight;
      } else {
        right.add(post);
        rightHeight += estimatedHeight;
      }
    }

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              for (var index = 0; index < left.length; index++) ...[
                _FeedCard(post: left[index]),
                if (index != left.length - 1) const SizedBox(height: 12),
              ],
            ],
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            children: [
              for (var index = 0; index < right.length; index++) ...[
                _FeedCard(post: right[index]),
                if (index != right.length - 1) const SizedBox(height: 12),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _FeedCard extends StatelessWidget {
  const _FeedCard({required this.post});

  final _FeedPost post;

  @override
  Widget build(BuildContext context) {
    return GlassPanel(
      color: CircleeColors.surfacePrimary,
      glowColor: CircleeColors.accentSky,
      padding: EdgeInsets.zero,
      radius: CircleeRadius.xl,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _MediaFrame(post: post),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: CircleeColors.surfaceTertiary,
                      child: Text(
                        post.creator.substring(0, 1),
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        post.creator,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                    Text(
                      post.viewers,
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  post.title,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  post.caption,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MediaFrame extends StatelessWidget {
  const _MediaFrame({
    required this.post,
    this.hero = false,
  });

  final _FeedPost post;
  final bool hero;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: hero ? 300 : post.mediaHeight,
      child: Stack(
        children: [
          Positioned.fill(
            child: ColoredBox(
              color: CircleeColors.surfaceTertiary,
            ),
          ),
          Positioned(
            left: -24,
            top: -10,
            child: _SoftOrb(size: hero ? 150 : 110, color: CircleeColors.accentSky),
          ),
          Positioned(
            right: -20,
            bottom: -20,
            child: _SoftOrb(size: hero ? 140 : 100, color: CircleeColors.accentMint),
          ),
          Positioned(
            top: 12,
            left: 12,
            child: _Pill(label: post.mood, tone: CircleeColors.accentSky),
          ),
          Positioned(
            top: 12,
            right: 12,
            child: _Pill(label: post.duration, tone: CircleeColors.textSecondary),
          ),
          Center(
            child: Container(
              width: hero ? 62 : 54,
              height: hero ? 62 : 54,
              decoration: BoxDecoration(
                color: CircleeColors.bgBase.withOpacity(0.70),
                shape: BoxShape.circle,
                border: Border.all(color: CircleeColors.accentSky.withOpacity(0.20)),
                boxShadow: CircleeShadows.glow(CircleeColors.accentSky),
              ),
              child: const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 32),
            ),
          ),
          Positioned(
            left: 12,
            right: hero ? 96 : 88,
            bottom: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.location,
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: CircleeColors.accentIce,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  post.caption,
                  maxLines: hero ? 2 : 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 12,
            bottom: 12,
            child: Column(
              children: [
                _ActionBubble(icon: Icons.favorite_rounded, count: post.likes),
                const SizedBox(height: 8),
                _ActionBubble(icon: Icons.mode_comment_rounded, count: post.comments),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.label, required this.tone});

  final String label;
  final Color tone;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      decoration: BoxDecoration(
        color: CircleeColors.bgBase.withOpacity(0.52),
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: tone.withOpacity(0.18)),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}

class _ActionBubble extends StatelessWidget {
  const _ActionBubble({
    required this.icon,
    required this.count,
  });

  final IconData icon;
  final String count;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: CircleeColors.bgBase.withOpacity(0.72),
        shape: BoxShape.circle,
        border: Border.all(color: CircleeColors.strokeMedium),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Icon(icon, size: 18, color: Colors.white),
          Positioned(
            bottom: 3,
            right: 2,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                color: CircleeColors.accentSky,
                borderRadius: BorderRadius.circular(99),
              ),
              child: Text(
                count,
                style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: CircleeColors.bgBase,
                  fontSize: 8,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SoftOrb extends StatelessWidget {
  const _SoftOrb({
    required this.size,
    required this.color,
  });

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color.withOpacity(0.14),
        boxShadow: CircleeShadows.glow(color),
      ),
    );
  }
}

class _MiniAvatarRing extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 74,
      height: 34,
      child: Stack(
        children: const [
          Positioned(left: 0, child: _MiniAvatar(label: 'M')),
          Positioned(left: 20, child: _MiniAvatar(label: 'Y')),
          Positioned(left: 40, child: _MiniAvatar(label: 'N')),
        ],
      ),
    );
  }
}

class _MiniAvatar extends StatelessWidget {
  const _MiniAvatar({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: CircleeColors.surfaceTertiary,
        shape: BoxShape.circle,
        border: Border.all(color: CircleeColors.strokeMedium),
      ),
      child: Text(
        label,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          color: Colors.white,
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ),
        const GlowPill(
          label: 'Clean mode',
          color: CircleeColors.accentSky,
          filled: true,
        ),
      ],
    );
  }
}

class _FeedPost {
  const _FeedPost({
    required this.title,
    required this.creator,
    required this.caption,
    required this.location,
    required this.mood,
    required this.likes,
    required this.comments,
    required this.viewers,
    required this.duration,
    required this.mediaHeight,
  });

  final String title;
  final String creator;
  final String caption;
  final String location;
  final String mood;
  final String likes;
  final String comments;
  final String viewers;
  final String duration;
  final double mediaHeight;
}
