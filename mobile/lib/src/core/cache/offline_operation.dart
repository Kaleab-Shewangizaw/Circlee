class OfflineOperation {
  const OfflineOperation({
    required this.id,
    required this.kind,
    required this.payload,
    required this.createdAtIso8601,
  });

  final String id;
  final String kind;
  final Map<String, Object?> payload;
  final String createdAtIso8601;
}

