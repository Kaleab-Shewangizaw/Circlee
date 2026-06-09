import 'package:flutter/material.dart';

import '../../../theme/design_tokens.dart';

class ActivityCategory {
  const ActivityCategory({
    required this.id,
    required this.label,
    required this.icon,
    required this.color,
    required this.surfaceColor,
  });

  final String id;
  final String label;
  final IconData icon;
  final Color color;
  final Color surfaceColor;
}

class CirclePreview {
  const CirclePreview({
    required this.id,
    required this.title,
    required this.categoryId,
    required this.mood,
    required this.locationHint,
    required this.vibeTag,
    required this.description,
    required this.organizer,
    required this.joinerNames,
    required this.joinerInitials,
    required this.tags,
    required this.chatTeaser,
    required this.isHot,
    required this.liveCount,
    required this.matchLine,
  });

  final String id;
  final String title;
  final String categoryId;
  final String mood;
  final String locationHint;
  final String vibeTag;
  final String description;
  final String organizer;
  final List<String> joinerNames;
  final List<String> joinerInitials;
  final List<String> tags;
  final String chatTeaser;
  final bool isHot;
  final int liveCount;
  final String matchLine;
}

class PersonPreview {
  const PersonPreview({
    required this.name,
    required this.initials,
    required this.subtitle,
    required this.status,
    required this.categoryId,
    required this.sharedCircleIds,
  });

  final String name;
  final String initials;
  final String subtitle;
  final String status;
  final String categoryId;
  final List<String> sharedCircleIds;
}

const categoryAnime = ActivityCategory(
  id: 'anime',
  label: 'Anime',
  icon: Icons.auto_awesome_rounded,
  color: CircleeColors.accentMint,
  surfaceColor: Color(0xFF1B1730),
);

const categoryFitness = ActivityCategory(
  id: 'fitness',
  label: 'Fitness',
  icon: Icons.bolt_rounded,
  color: CircleeColors.accentSky,
  surfaceColor: Color(0xFF131D31),
);

const categoryTravel = ActivityCategory(
  id: 'travel',
  label: 'Travel',
  icon: Icons.flight_takeoff_rounded,
  color: CircleeColors.accentGold,
  surfaceColor: Color(0xFF17192E),
);

const categoryMusic = ActivityCategory(
  id: 'music',
  label: 'Music',
  icon: Icons.graphic_eq_rounded,
  color: CircleeColors.accentCoral,
  surfaceColor: Color(0xFF1D1730),
);

const categoryFood = ActivityCategory(
  id: 'food',
  label: 'Food',
  icon: Icons.ramen_dining_rounded,
  color: CircleeColors.accentRose,
  surfaceColor: Color(0xFF1A1730),
);

const categoryStudy = ActivityCategory(
  id: 'study',
  label: 'Study',
  icon: Icons.menu_book_rounded,
  color: CircleeColors.accentSky,
  surfaceColor: Color(0xFF141F34),
);

const categoryMovies = ActivityCategory(
  id: 'movies',
  label: 'Movies',
  icon: Icons.movie_creation_rounded,
  color: CircleeColors.accentGold,
  surfaceColor: Color(0xFF17192D),
);

const categoryGaming = ActivityCategory(
  id: 'gaming',
  label: 'Gaming',
  icon: Icons.videogame_asset_rounded,
  color: CircleeColors.accentSky,
  surfaceColor: Color(0xFF151E34),
);

const categoryNature = ActivityCategory(
  id: 'nature',
  label: 'Nature',
  icon: Icons.forest_rounded,
  color: CircleeColors.accentMint,
  surfaceColor: Color(0xFF171C2F),
);

const categories = [
  categoryAnime,
  categoryFitness,
  categoryTravel,
  categoryMusic,
  categoryFood,
  categoryStudy,
  categoryMovies,
  categoryGaming,
  categoryNature,
];

const demoCircles = [
  CirclePreview(
    id: 'anime-night',
    title: 'Anime Night on the Roof',
    categoryId: 'anime',
    mood: 'Chill',
    locationHint: 'Bole rooftops · 12 min away',
    vibeTag: 'soft chaos',
    description: 'Blankets, projector glow, and the kind of crowd that can talk openings for hours without it feeling forced.',
    organizer: 'Mika',
    joinerNames: ['Mika', 'Zara', 'Yusuf', 'Leah', 'Noah'],
    joinerInitials: ['MI', 'ZA', 'YU', 'LE', 'NO'],
    tags: ['Open to strangers 👋', 'Just friends ✌️', 'Late night'],
    chatTeaser: 'Mika: bring snacks if you’re the generous type.',
    isHot: true,
    liveCount: 34,
    matchLine: 'Also joining Anime Night',
  ),
  CirclePreview(
    id: 'sunrise-run',
    title: 'Sunrise Run Crew',
    categoryId: 'fitness',
    mood: 'Active',
    locationHint: 'Entoto trail · tomorrow 6:00 AM',
    vibeTag: 'disciplined but kind',
    description: 'A small electric group that actually shows up, hypes each other up, and gets coffee after.',
    organizer: 'Ari',
    joinerNames: ['Ari', 'Mila', 'Henok', 'Sam'],
    joinerInitials: ['AR', 'MI', 'HE', 'SA'],
    tags: ['Group only', 'Consistency', 'After-run coffee'],
    chatTeaser: 'Ari: if you’re new, no pressure to keep pace.',
    isHot: false,
    liveCount: 11,
    matchLine: 'Down for plans this weekend',
  ),
  CirclePreview(
    id: 'lalibela-dreamers',
    title: 'Lalibela Dreamers',
    categoryId: 'travel',
    mood: 'Creative',
    locationHint: 'Trip planning · virtual tonight',
    vibeTag: 'hopeful and curious',
    description: 'A travel circle for people who don’t just want photos. They want stories, detours, and people worth remembering.',
    organizer: 'Nora',
    joinerNames: ['Nora', 'Dani', 'Ruth', 'Liya'],
    joinerInitials: ['NO', 'DA', 'RU', 'LI'],
    tags: ['Open to strangers 👋', 'Weekend planners', 'Story lovers'],
    chatTeaser: 'Nora: okay but who’s making the playlist for the road?',
    isHot: false,
    liveCount: 9,
    matchLine: 'Wants to travel to Lalibela',
  ),
  CirclePreview(
    id: 'vinyl-after-dark',
    title: 'Vinyl After Dark',
    categoryId: 'music',
    mood: 'Social',
    locationHint: 'Piassa loft · tonight 8:30 PM',
    vibeTag: 'beautiful strangers',
    description: 'Come for the album swaps, stay because somehow everyone starts opening up around track four.',
    organizer: 'Tino',
    joinerNames: ['Tino', 'Ava', 'Rai', 'Mo'],
    joinerInitials: ['TI', 'AV', 'RA', 'MO'],
    tags: ['Romantic-friendly 🌹', 'Small room', 'No ego DJs'],
    chatTeaser: 'Ava: someone please bring a heartbreak record.',
    isHot: false,
    liveCount: 22,
    matchLine: 'Also loves vinyl and late-night hangs',
  ),
  CirclePreview(
    id: 'noodle-club',
    title: 'Midnight Noodle Club',
    categoryId: 'food',
    mood: 'Romantic',
    locationHint: 'Kazanchis ramen spot · tonight',
    vibeTag: 'warm and flirty',
    description: 'A tiny circle for people who think good food is already enough of a reason to meet.',
    organizer: 'Leah',
    joinerNames: ['Leah', 'Ken', 'Sofi'],
    joinerInitials: ['LE', 'KE', 'SO'],
    tags: ['Romantic-friendly 🌹', 'Open to strangers 👋', 'Cozy table'],
    chatTeaser: 'Leah: if you like spicy broth, we already get along.',
    isHot: false,
    liveCount: 7,
    matchLine: 'You both save food circles',
  ),
  CirclePreview(
    id: 'study-sprint',
    title: 'Blue Hour Study Sprint',
    categoryId: 'study',
    mood: 'Chill',
    locationHint: 'Library annex · starts in 40 min',
    vibeTag: 'focused with soft banter',
    description: 'Study together, keep the energy light, and leave feeling less alone in whatever you’re working through.',
    organizer: 'Yara',
    joinerNames: ['Yara', 'Mahi', 'Eden', 'Theo'],
    joinerInitials: ['YA', 'MA', 'ED', 'TH'],
    tags: ['Study session', 'Quiet first half', 'Snacks welcome'],
    chatTeaser: 'Yara: first 50 minutes silent, then tea break.',
    isHot: false,
    liveCount: 18,
    matchLine: 'Same exam season energy',
  ),
];

const demoPeople = [
  PersonPreview(
    name: 'Mika',
    initials: 'MI',
    subtitle: 'Also joining Anime Night',
    status: 'loves rooftop plans and emotional openings',
    categoryId: 'anime',
    sharedCircleIds: ['anime-night', 'vinyl-after-dark'],
  ),
  PersonPreview(
    name: 'Henok',
    initials: 'HE',
    subtitle: 'Wants to run Entoto at sunrise',
    status: 'consistent, easygoing, and weirdly motivating',
    categoryId: 'fitness',
    sharedCircleIds: ['sunrise-run'],
  ),
  PersonPreview(
    name: 'Nora',
    initials: 'NO',
    subtitle: 'Wants to travel to Lalibela',
    status: 'collects itineraries like love letters',
    categoryId: 'travel',
    sharedCircleIds: ['lalibela-dreamers'],
  ),
  PersonPreview(
    name: 'Ava',
    initials: 'AV',
    subtitle: 'Shares your late-night music taste',
    status: 'down for intimate circles, not loud crowds',
    categoryId: 'music',
    sharedCircleIds: ['vinyl-after-dark', 'anime-night'],
  ),
  PersonPreview(
    name: 'Leah',
    initials: 'LE',
    subtitle: 'Saved Midnight Noodle Club too',
    status: 'food first, chemistry second, no pressure',
    categoryId: 'food',
    sharedCircleIds: ['noodle-club'],
  ),
  PersonPreview(
    name: 'Yara',
    initials: 'YA',
    subtitle: 'Same study sprint this week',
    status: 'quiet, kind, and always brings tea',
    categoryId: 'study',
    sharedCircleIds: ['study-sprint'],
  ),
];

ActivityCategory categoryById(String id) {
  return categories.firstWhere(
    (category) => category.id == id,
    orElse: () => categoryGaming,
  );
}

CirclePreview circleById(String id) {
  return demoCircles.firstWhere(
    (circle) => circle.id == id,
    orElse: () => demoCircles.first,
  );
}
