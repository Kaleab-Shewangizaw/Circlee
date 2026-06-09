import 'package:flutter/material.dart';

import '../../../theme/design_tokens.dart';

class ActiveAvatarCluster extends StatelessWidget {
  const ActiveAvatarCluster({
    required this.initials,
    this.limit = 4,
    this.ringColor = CircleeColors.accentMint,
    this.size = 42,
    this.active = true,
    super.key,
  });

  final List<String> initials;
  final int limit;
  final Color ringColor;
  final double size;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final visible = initials.take(limit).toList();
    final extra = initials.length - visible.length;
    final overlap = size * 0.58;
    final width = visible.isEmpty
        ? size
        : (visible.length - 1) * overlap + size + (extra > 0 ? overlap : 0);

    return SizedBox(
      width: width,
      height: size,
      child: Stack(
        children: [
          for (var index = 0; index < visible.length; index++)
            Positioned(
              left: index * overlap,
              child: _AvatarBubble(
                initials: visible[index],
                size: size,
                ringColor: ringColor,
                active: active && index == 0,
              ),
            ),
          if (extra > 0)
            Positioned(
              left: visible.length * overlap,
              child: Container(
                width: size,
                height: size,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: CircleeColors.surfaceTertiary,
                  shape: BoxShape.circle,
                  border: Border.all(color: CircleeColors.strokeStrong),
                ),
                child: Text(
                  '+$extra',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _AvatarBubble extends StatelessWidget {
  const _AvatarBubble({
    required this.initials,
    required this.size,
    required this.ringColor,
    required this.active,
  });

  final String initials;
  final double size;
  final Color ringColor;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.92, end: 1),
      duration: const Duration(milliseconds: 2200),
      curve: Curves.easeInOut,
      builder: (context, value, child) {
        return Transform.scale(scale: active ? value : 1, child: child);
      },
      child: Container(
        width: size,
        height: size,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: active ? CircleeShadows.glow(ringColor) : null,
          color: const Color(0xFF223448),
          border: Border.all(
            color: active ? ringColor : Colors.white.withOpacity(0.18),
            width: active ? 2.3 : 1.2,
          ),
        ),
        child: Text(
          initials,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
