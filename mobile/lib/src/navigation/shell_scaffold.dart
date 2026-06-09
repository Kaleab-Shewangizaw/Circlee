import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/shared/widgets/ambient_background.dart';
import '../theme/design_tokens.dart';

class ShellScaffold extends StatelessWidget {
  const ShellScaffold({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      backgroundColor: CircleeColors.bgBase,
      body: Stack(
        children: [
          const Positioned.fill(child: AmbientBackground()),
          SafeArea(
            bottom: false,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 110),
              child: navigationShell,
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              minimum: const EdgeInsets.fromLTRB(14, 0, 14, 14),
              child: _BottomDock(
                currentIndex: navigationShell.currentIndex,
                onSelected: (index) => navigationShell.goBranch(index),
                onCreateTap: () => context.push('/create'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomDock extends StatelessWidget {
  const _BottomDock({
    required this.currentIndex,
    required this.onSelected,
    required this.onCreateTap,
  });

  final int currentIndex;
  final ValueChanged<int> onSelected;
  final VoidCallback onCreateTap;

  @override
  Widget build(BuildContext context) {
    const items = [
      _DockItemData(label: 'Home', icon: Icons.home_rounded),
      _DockItemData(label: 'People', icon: Icons.groups_rounded),
      _DockItemData(label: 'Inbox', icon: Icons.forum_rounded),
      _DockItemData(label: 'You', icon: Icons.face_retouching_natural_rounded),
    ];

    return SizedBox(
      height: 86,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Positioned.fill(
            top: 18,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(CircleeRadius.xxl),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
                child: Container(
                  decoration: BoxDecoration(
                    color: CircleeColors.surfaceGlass,
                    borderRadius: BorderRadius.circular(CircleeRadius.xxl),
                    border: Border.all(color: CircleeColors.strokeMedium),
                    boxShadow: CircleeShadows.panel(),
                  ),
                  padding: const EdgeInsets.fromLTRB(12, 16, 12, 12),
                  child: Row(
                    children: [
                      for (var index = 0; index < items.length; index++) ...[
                        Expanded(
                          child: _DockItem(
                            data: items[index],
                            selected: currentIndex == index,
                            onTap: () => onSelected(index),
                          ),
                        ),
                        if (index == 1) const SizedBox(width: 64),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          ),
          _CreateButton(onTap: onCreateTap),
        ],
      ),
    );
  }
}

class _CreateButton extends StatelessWidget {
  const _CreateButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(999),
      child: Container(
        width: 58,
        height: 58,
        decoration: BoxDecoration(
          color: CircleeColors.accentSky,
          shape: BoxShape.circle,
          border: Border.all(color: CircleeColors.accentMint.withOpacity(0.30), width: 1.5),
          boxShadow: CircleeShadows.glow(CircleeColors.accentSky),
        ),
        child: const Icon(Icons.add_rounded, color: CircleeColors.bgBase, size: 28),
      ),
    );
  }
}

class _DockItem extends StatelessWidget {
  const _DockItem({
    required this.data,
    required this.selected,
    required this.onTap,
  });

  final _DockItemData data;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
      height: 46,
      decoration: BoxDecoration(
        color: selected ? CircleeFills.aurora : Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: selected ? CircleeColors.accentSky.withOpacity(0.24) : Colors.transparent,
        ),
        boxShadow: selected ? CircleeShadows.glow(CircleeColors.accentSky) : null,
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              data.icon,
              size: 20,
              color: selected ? Colors.white : CircleeColors.textMuted,
            ),
            const SizedBox(height: 3),
            Text(
              data.label,
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: selected ? Colors.white : CircleeColors.textMuted,
                fontSize: 10.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DockItemData {
  const _DockItemData({required this.label, required this.icon});

  final String label;
  final IconData icon;
}
