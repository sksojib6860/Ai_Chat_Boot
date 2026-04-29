import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  const TextWidget({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
      elevation: 0.5,
      shadowColor: Colors.grey,
      color: Colors.grey.shade200,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Text(text, style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
