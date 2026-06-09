import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/message.dart';

final chatControllerProvider = NotifierProvider.family<ChatController, ChatState, String>(
  ChatController.new,
);

class ChatController extends FamilyNotifier<ChatState, String> {
  @override
  ChatState build(String arg) {
    return const ChatState(messages: []);
  }

  void addOptimisticMessage(Message message) {
    state = ChatState(messages: [...state.messages, message]);
  }
}

class ChatState {
  const ChatState({required this.messages});

  final List<Message> messages;
}

