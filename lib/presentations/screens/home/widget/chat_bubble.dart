import 'package:flutter/material.dart';

import '../../../../core/constants/app_color.dart';
import '../../../../data/model/message_model.dart';

class ChatBubble extends StatelessWidget {
  final MessageModel message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    bool isUser = message.role == 'user';

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Column(
        crossAxisAlignment:
            isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment:
                isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (!isUser) ...[
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                  child: Icon(Icons.smart_toy_outlined,
                      size: 18, color: AppColors.primary),
                ),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: isUser ? AppColors.userBubble : AppColors.botBubble,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(20),
                      topRight: const Radius.circular(20),
                      bottomLeft: Radius.circular(isUser ? 20 : 0),
                      bottomRight: Radius.circular(isUser ? 0 : 20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 5,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    message.text,
                    style: TextStyle(
                      color: isUser ? AppColors.userText : AppColors.botText,
                      fontSize: 15,
                      height: 1.4,
                    ),
                  ),
                ),
              ),
              if (isUser) ...[
                const SizedBox(width: 8),
                CircleAvatar(
                  radius: 16,
                  backgroundColor: AppColors.primary,
                  child: const Icon(Icons.person_outline,
                      size: 18, color: Colors.white),
                ),
              ],
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 4, left: 40, right: 40),
            child: Text(
              _formatTime(message.timeDate),
              style: const TextStyle(color: AppColors.timestamp, fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime date) {
    return "${date.hour}:${date.minute.toString().padLeft(2, '0')}";
  }
}
