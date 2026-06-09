import 'package:flutter/material.dart';

class Reveal extends StatelessWidget {
  const Reveal({
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 620),
    this.offset = const Offset(0, 18),
    super.key,
  });

  final Widget child;
  final Duration delay;
  final Duration duration;
  final Offset offset;

  @override
  Widget build(BuildContext context) {
    final totalMs = duration.inMilliseconds + delay.inMilliseconds;
    final normalizedStart = totalMs == 0 ? 0.0 : delay.inMilliseconds / totalMs;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: totalMs == 0 ? 1 : totalMs),
      curve: Curves.linear,
      child: child,
      builder: (context, value, child) {
        final progress = Interval(
          normalizedStart,
          1,
          curve: Curves.easeOutCubic,
        ).transform(value);

        return Opacity(
          opacity: progress,
          child: Transform.translate(
            offset: Offset(
              (1 - progress) * offset.dx,
              (1 - progress) * offset.dy,
            ),
            child: Transform.scale(
              scale: 0.985 + (progress * 0.015),
              child: child,
            ),
          ),
        );
      },
    );
  }
}

