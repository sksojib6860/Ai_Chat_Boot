import 'package:flutter/material.dart';
import 'package:llm_ai_chat_bot/presentations/screens/home/widget/bot_icon_widget.dart';
import 'package:llm_ai_chat_bot/presentations/screens/home/widget/chat_text_field.dart';
import 'package:llm_ai_chat_bot/presentations/screens/home/widget/text_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          spacing: 40,
          mainAxisAlignment: .center,
          children: [
            SizedBox(height: 70),
            Expanded(
              child: Center(
                child: Column(
                  children: [
                    BotIconWidget(),
                    SizedBox(height: 10),
                    TextWidget(text: 'Hello!!'),
                    SizedBox(height: 10),
                    TextWidget(text: 'How can i help you?'),
                  ],
                ),
              ),
            ),
            ChatTextField(),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
