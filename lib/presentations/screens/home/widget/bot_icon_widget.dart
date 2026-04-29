import 'package:flutter/material.dart';

class BotIconWidget extends StatelessWidget {
  const BotIconWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 80,
      backgroundColor: Colors.grey.shade500,
      child: Icon(Icons.smart_toy_outlined, size: 150, color: Colors.black54),
    );
  }
}
