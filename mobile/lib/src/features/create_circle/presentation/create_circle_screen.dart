import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';

import '../../../theme/design_tokens.dart';
import '../../shared/data/social_graph_demo_data.dart';
import '../../shared/widgets/glass_panel.dart';
import '../../shared/widgets/glow_pill.dart';
import '../../shared/widgets/reveal.dart';
import '../../shared/widgets/scene_scaffold.dart';

class CreateCircleScreen extends HookWidget {
  const CreateCircleScreen({super.key});

  static const _steps = [
    'Category',
    'Name',
    'Intent',
    'When',
    'Preview',
  ];

  static const _intentTags = [
    'Chill hangout',
    'Adventure',
    'Group only',
    'Open to romance',
    'Study session',
    'Creative night',
    'After-work linkup',
    'Just friends',
  ];

  @override
  Widget build(BuildContext context) {
    final step = useState(0);
    final selectedCategory = useState<ActivityCategory>(categoryAnime);
    final selectedTags = useState<Set<String>>({'Chill hangout', 'Just friends'});
    final nameController = useTextEditingController(text: 'Moonlight Story Circle');
    final dateController = useTextEditingController(text: 'Saturday · 8:30 PM');
    final locationController = useTextEditingController(text: 'Bole rooftop terrace');
    final isVirtual = useState(false);
    useListenable(nameController);
    useListenable(dateController);
    useListenable(locationController);

    return SceneScaffold(
      bottomBar: Padding(
        padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
        child: SafeArea(
          top: false,
          child: GlassPanel(
            glowColor: selectedCategory.value.color,
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                if (step.value > 0)
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => step.value -= 1,
                      child: const Text('Back'),
                    ),
                  ),
                if (step.value > 0) const SizedBox(width: 10),
                Expanded(
                  flex: 2,
                  child: FilledButton(
                    onPressed: () {
                      if (step.value < _steps.length - 1) {
                        step.value += 1;
                      } else {
                        context.pop();
                      }
                    },
                    style: FilledButton.styleFrom(
                      backgroundColor: selectedCategory.value.color,
                      foregroundColor: CircleeColors.bgBase,
                    ),
                    child: Text(step.value == _steps.length - 1 ? 'Share Circle' : 'Next'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      child: ListView(
        padding: const EdgeInsets.fromLTRB(24, 18, 24, 160),
        children: [
          Reveal(
            child: Row(
              children: [
                InkWell(
                  onTap: () => context.pop(),
                  borderRadius: BorderRadius.circular(18),
                  child: Ink(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: CircleeColors.surfaceGlass,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: CircleeColors.strokeSoft),
                    ),
                    child: const Icon(Icons.close_rounded, color: Colors.white),
                  ),
                ),
                const Spacer(),
                Text(
                  'Create a Circle',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const Spacer(),
                const SizedBox(width: 46),
              ],
            ),
          ),
          const SizedBox(height: CircleeSpacing.xxl),
          Reveal(
            delay: const Duration(milliseconds: 80),
            child: _StepTracker(
              currentStep: step.value,
              activeColor: selectedCategory.value.color,
            ),
          ),
          const SizedBox(height: CircleeSpacing.xxl),
          Reveal(
            delay: const Duration(milliseconds: 140),
            child: Text(
              _steps[step.value],
              style: Theme.of(context).textTheme.headlineLarge,
            ),
          ),
          const SizedBox(height: CircleeSpacing.sm),
          Reveal(
            delay: const Duration(milliseconds: 180),
            child: Text(
              _stepSubtitle(step.value),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          const SizedBox(height: CircleeSpacing.xxl),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 320),
            switchInCurve: Curves.easeOutCubic,
            switchOutCurve: Curves.easeInCubic,
            child: KeyedSubtree(
              key: ValueKey(step.value),
              child: switch (step.value) {
                0 => _CategoryStep(
                    selectedCategory: selectedCategory.value,
                    onSelected: (category) => selectedCategory.value = category,
                  ),
                1 => _NameStep(
                    category: selectedCategory.value,
                    nameController: nameController,
                  ),
                2 => _IntentStep(
                    category: selectedCategory.value,
                    selectedTags: selectedTags.value,
                    onToggle: (tag) {
                      final next = {...selectedTags.value};
                      if (next.contains(tag)) {
                        next.remove(tag);
                      } else {
                        next.add(tag);
                      }
                      selectedTags.value = next;
                    },
                  ),
                3 => _WhenStep(
                    category: selectedCategory.value,
                    dateController: dateController,
                    locationController: locationController,
                    isVirtual: isVirtual.value,
                    onVirtualChanged: (value) => isVirtual.value = value,
                  ),
                _ => _PreviewStep(
                    category: selectedCategory.value,
                    title: nameController.text,
                    tags: selectedTags.value.toList(),
                    when: dateController.text,
                    location: isVirtual.value ? 'Virtual circle' : locationController.text,
                  ),
              },
            ),
          ),
        ],
      ),
    );
  }

  String _stepSubtitle(int step) {
    switch (step) {
      case 0:
        return 'Pick the energy first. Every category gets its own mood, color, and social rhythm.';
      case 1:
        return 'Name it like something people would actually want to screenshot and send.';
      case 2:
        return 'Set the tone without sounding robotic.';
      case 3:
        return 'Give people a clear plan with zero ambiguity.';
      case 4:
      default:
        return 'This should already feel like something worth joining.';
    }
  }
}

class _StepTracker extends StatelessWidget {
  const _StepTracker({
    required this.currentStep,
    required this.activeColor,
  });

  final int currentStep;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var index = 0; index < CreateCircleScreen._steps.length; index++) ...[
          Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 240),
              height: 10,
              decoration: BoxDecoration(
                color: index <= currentStep ? activeColor : CircleeColors.surfaceSecondary,
                borderRadius: BorderRadius.circular(99),
              ),
            ),
          ),
          if (index != CreateCircleScreen._steps.length - 1)
            const SizedBox(width: 8),
        ],
      ],
    );
  }
}

class _CategoryStep extends StatelessWidget {
  const _CategoryStep({
    required this.selectedCategory,
    required this.onSelected,
  });

  final ActivityCategory selectedCategory;
  final ValueChanged<ActivityCategory> onSelected;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        childAspectRatio: 0.92,
      ),
      itemBuilder: (context, index) {
        final category = categories[index];
        final selected = category.id == selectedCategory.id;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 240),
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            color: selected ? category.surfaceColor : CircleeColors.surfaceSecondary,
            borderRadius: BorderRadius.circular(CircleeRadius.lg),
            border: Border.all(
              color: selected ? Colors.white.withOpacity(0.20) : CircleeColors.strokeSoft,
            ),
            boxShadow: selected ? CircleeShadows.glow(category.color) : null,
          ),
          child: InkWell(
            onTap: () => onSelected(category),
            borderRadius: BorderRadius.circular(CircleeRadius.lg),
            child: Padding(
              padding: const EdgeInsets.all(CircleeSpacing.lg),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    category.icon,
                    size: 30,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    category.label,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _NameStep extends StatelessWidget {
  const _NameStep({
    required this.category,
    required this.nameController,
  });

  final ActivityCategory category;
  final TextEditingController nameController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: nameController,
          style: Theme.of(context).textTheme.titleMedium,
          decoration: const InputDecoration(
            hintText: 'Name your circle',
          ),
        ),
        const SizedBox(height: CircleeSpacing.xxl),
        GlassPanel(
          color: category.surfaceColor,
          glowColor: category.color,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GlowPill(
                label: category.label,
                color: category.color,
                icon: category.icon,
                filled: true,
              ),
              const SizedBox(height: CircleeSpacing.xxl),
              Text(
                nameController.text.isEmpty ? 'Your circle title goes here' : nameController.text,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: CircleeSpacing.md),
              Text(
                'Live preview: make it feel like a real invitation, not a generic group name.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: CircleeColors.accentIce,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _IntentStep extends StatelessWidget {
  const _IntentStep({
    required this.category,
    required this.selectedTags,
    required this.onToggle,
  });

  final ActivityCategory category;
  final Set<String> selectedTags;
  final ValueChanged<String> onToggle;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        for (final tag in CreateCircleScreen._intentTags)
          AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            decoration: BoxDecoration(
              color: selectedTags.contains(tag)
                  ? category.surfaceColor
                  : CircleeColors.surfaceSecondary,
              borderRadius: BorderRadius.circular(99),
              border: Border.all(
                color: selectedTags.contains(tag)
                    ? Colors.white.withOpacity(0.18)
                    : CircleeColors.strokeSoft,
              ),
            ),
            child: InkWell(
              onTap: () => onToggle(tag),
              borderRadius: BorderRadius.circular(99),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                child: Text(
                  tag,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _WhenStep extends StatelessWidget {
  const _WhenStep({
    required this.category,
    required this.dateController,
    required this.locationController,
    required this.isVirtual,
    required this.onVirtualChanged,
  });

  final ActivityCategory category;
  final TextEditingController dateController;
  final TextEditingController locationController;
  final bool isVirtual;
  final ValueChanged<bool> onVirtualChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: dateController,
          decoration: const InputDecoration(
            labelText: 'Date and time',
            hintText: 'Friday · 7:00 PM',
          ),
        ),
        const SizedBox(height: 14),
        TextField(
          controller: locationController,
          enabled: !isVirtual,
          decoration: InputDecoration(
            labelText: 'Location',
            hintText: isVirtual ? 'Virtual circle' : 'Where is this happening?',
          ),
        ),
        const SizedBox(height: 14),
        GlassPanel(
          glowColor: category.color,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Row(
            children: [
              Icon(
                isVirtual ? Icons.language_rounded : Icons.location_on_rounded,
                color: category.color,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  isVirtual ? 'This circle is virtual' : 'This circle happens in the real world',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              Switch(
                value: isVirtual,
                onChanged: onVirtualChanged,
                activeColor: category.color,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _PreviewStep extends StatelessWidget {
  const _PreviewStep({
    required this.category,
    required this.title,
    required this.tags,
    required this.when,
    required this.location,
  });

  final ActivityCategory category;
  final String title;
  final List<String> tags;
  final String when;
  final String location;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GlassPanel(
          color: category.surfaceColor,
          glowColor: category.color,
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
                  const GlowPill(
                    label: 'Shareable preview',
                    color: CircleeColors.accentGold,
                  ),
                ],
              ),
              const SizedBox(height: CircleeSpacing.xxl),
              Text(
                title.isEmpty ? 'Untitled circle' : title,
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                '$when · $location',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: CircleeColors.accentIce,
                ),
              ),
              const SizedBox(height: CircleeSpacing.xl),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: tags
                    .map(
                      (tag) => GlowPill(
                        label: tag,
                        color: Colors.white,
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: CircleeSpacing.xxl),
              Text(
                'A clean, glowing card people can screenshot and send without needing to explain what Circlee is.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: CircleeColors.accentIce,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: CircleeSpacing.xl),
        Text(
          'Preview cards should spread on their own.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ],
    );
  }
}
