import 'package:flutter/material.dart';

import 'ambient_background.dart';

class SceneScaffold extends StatelessWidget {
  const SceneScaffold({
    required this.child,
    this.appBar,
    this.bottomBar,
    super.key,
  });

  final PreferredSizeWidget? appBar;
  final Widget child;
  final Widget? bottomBar;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      backgroundColor: Colors.transparent,
      appBar: appBar,
      bottomNavigationBar: bottomBar,
      body: Stack(
        children: [
          const Positioned.fill(child: AmbientBackground()),
          SafeArea(child: child),
        ],
      ),
    );
  }
}
