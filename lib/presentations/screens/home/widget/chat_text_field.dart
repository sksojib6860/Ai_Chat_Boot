import 'package:flutter/material.dart';

import '../../../../core/constants/app_color.dart';

class ChatTextField extends StatefulWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final String hintText;

  const ChatTextField({
    super.key,
    required this.controller,
    required this.onSend,
    this.hintText = 'Type a message...',
  });

  @override
  State<ChatTextField> createState() => _ChatTextFieldState();
}

class _ChatTextFieldState extends State<ChatTextField> {
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_updateTextState);
  }

  void _updateTextState() {
    if (widget.controller.text.isNotEmpty != _hasText) {
      setState(() {
        _hasText = widget.controller.text.isNotEmpty;
      });
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_updateTextState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.inputBackground,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextField(
                  controller: widget.controller,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: const TextStyle(color: Colors.grey, fontSize: 15),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            GestureDetector(
              onTap: _hasText ? widget.onSend : null,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: _hasText ? AppColors.primaryGradient : null,
                  color: _hasText ? null : Colors.grey.shade300,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.send_rounded,
                  color: _hasText ? Colors.white : Colors.grey.shade500,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
