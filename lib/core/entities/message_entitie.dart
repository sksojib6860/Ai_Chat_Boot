class MessageEntities {
  final String role;
  final String text;
  final DateTime timeDate;

  MessageEntities({
    required this.role,
    required this.text,
    required this.timeDate,
  });
  bool get isUser => role == 'user';
}
