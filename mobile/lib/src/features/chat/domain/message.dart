class Message {
  const Message({
    required this.id,
    required this.conversationId,
    required this.senderId,
    required this.body,
    required this.createdAtIso8601,
    required this.clientNonce,
  });

  final String id;
  final String conversationId;
  final String senderId;
  final String body;
  final String createdAtIso8601;
  final String clientNonce;
}

