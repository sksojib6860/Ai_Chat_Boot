import '../../core/entities/message_entitie.dart';

class MessageModel extends MessageEntities {
  MessageModel({
    required super.role,
    required super.text,
    required super.timeDate,
    super.messageType = MessageType.text,
    super.imageUrl,
  });

  factory MessageModel.sampleUser() => MessageModel(
      role: 'user', text: 'i need career help', timeDate: DateTime.now());

  factory MessageModel.sampleBot() => MessageModel(
      role: 'assistant',
      text:
          'Absolutely. Tell me a bit about your situation and what kind of help you want.',
      timeDate: DateTime.now());

  Map<String, String> toApiMap() => {'role': role, 'content': text};
}
