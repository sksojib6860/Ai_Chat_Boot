import 'package:flutter/material.dart';
import 'package:llm_ai_chat_bot/presentations/screens/home/widget/typing_indicator.dart';
import 'package:provider/provider.dart';

import '../../../core/constants/app_color.dart';
import '../../../core/constants/app_strings.dart';
import '../../providers/chat_provider.dart';
import 'widget/chat_bubble.dart';
import 'widget/chat_text_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String name = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (context, chatProvider, child) {
        if (chatProvider.messages.isNotEmpty) {
          _scrollToBottom();
        }

        return Scaffold(
          backgroundColor: AppColors.background,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title: Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: AppColors.primary.withValues(alpha: 0.1),
                  child: const Icon(Icons.smart_toy_outlined,
                      size: 20, color: AppColors.primary),
                ),
                const SizedBox(width: 12),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'AI Assistant',
                      style: TextStyle(
                          color: AppColors.botText,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Online',
                      style: TextStyle(color: Colors.green, fontSize: 12),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              IconButton(
                onPressed: chatProvider.clearChat,
                icon: const Icon(Icons.delete_outline, color: Colors.grey),
              ),
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: chatProvider.messages.isEmpty
                    ? _buildWelcomeScreen()
                    : ListView.builder(
                        controller: _scrollController,
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        itemCount: chatProvider.messages.length +
                            (chatProvider.isLoading ? 1 : 0),
                        itemBuilder: (context, index) {
                          if (index == chatProvider.messages.length) {
                            return const TypingIndicator();
                          }
                          return ChatBubble(
                              message: chatProvider.messages[index]);
                        },
                      ),
              ),
              if (chatProvider.errorMessage != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    chatProvider.errorMessage!,
                    style:
                        const TextStyle(color: AppColors.error, fontSize: 12),
                  ),
                ),
              ChatTextField(
                controller: _controller,
                onSend: () {
                  final text = _controller.text;
                  _controller.clear();
                  chatProvider.sendMessage(text);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWelcomeScreen() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withValues(alpha: 0.05),
              ),
              child: const Icon(
                Icons.smart_toy_outlined,
                size: 80,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              AppStrings.helloText,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.botText,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              AppStrings.howCanIHelpYou,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 40),
            _buildQuickActions(),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions() {
    final actions = [
      'Tell me a joke',
      'How does AI work?',
      'Write a poem',
      'Career advice'
    ];
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: actions.map((action) {
        return ActionChip(
          label: Text(action),
          onPressed: () => context.read<ChatProvider>().sendMessage(action),
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.grey.shade200),
          ),
        );
      }).toList(),
    );
  }
}
