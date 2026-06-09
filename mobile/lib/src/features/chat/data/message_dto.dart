import '../domain/message.dart';

class MessageDto {
  const MessageDto({
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

  Message toDomain() {
    return Message(
      id: id,
      conversationId: conversationId,
      senderId: senderId,
      body: body,
      createdAtIso8601: createdAtIso8601,
      clientNonce: clientNonce,
    );
  }
}

