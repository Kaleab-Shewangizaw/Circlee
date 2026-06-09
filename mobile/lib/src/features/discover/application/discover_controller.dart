import 'package:flutter_riverpod/flutter_riverpod.dart';

final discoverControllerProvider =
    AsyncNotifierProvider<DiscoverController, DiscoverState>(DiscoverController.new);

class DiscoverController extends AsyncNotifier<DiscoverState> {
  @override
  Future<DiscoverState> build() async {
    return const DiscoverState(
      headline: 'People and circles that match your current energy',
    );
  }
}

class DiscoverState {
  const DiscoverState({required this.headline});

  final String headline;
}

