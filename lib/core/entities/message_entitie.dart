enum MessageType { text, image }

class MessageEntities {
  final String role;
  final String text;
  final DateTime timeDate;
  final MessageType messageType;
  final String? imageUrl;

  MessageEntities({
    required this.role,
    required this.text,
    required this.timeDate,
    this.messageType = MessageType.text,
    this.imageUrl,
  });
  bool get isUser => role == 'user';
}
