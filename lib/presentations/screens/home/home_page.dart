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
                  child: Icon(
                      chatProvider.currentMode == ChatMode.chat
                          ? Icons.smart_toy_outlined
                          : Icons.image_outlined,
                      size: 20,
                      color: AppColors.primary),
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chatProvider.currentMode == ChatMode.chat
                          ? 'AI Chat Bot'
                          : 'AI Image Generator',
                      style: const TextStyle(
                          color: AppColors.botText,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    const Text(
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
                    ? _buildWelcomeScreen(chatProvider)
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
                hintText: chatProvider.currentMode == ChatMode.chat
                    ? 'Type a message...'
                    : 'Describe the image you want...',
                onSend: () {
                  final text = _controller.text;
                  _controller.clear();
                  chatProvider.sendMessage(text);
                },
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: chatProvider.currentMode == ChatMode.chat ? 0 : 1,
            onTap: (index) {
              chatProvider.setMode(index == 0 ? ChatMode.chat : ChatMode.image);
            },
            selectedItemColor: AppColors.primary,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble_outline),
                label: 'Chat',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.image_outlined),
                label: 'Image',
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildWelcomeScreen(ChatProvider chatProvider) {
    bool isChat = chatProvider.currentMode == ChatMode.chat;
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
              child: Icon(
                isChat ? Icons.smart_toy_outlined : Icons.palette_outlined,
                size: 80,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              isChat ? AppStrings.helloText : 'Image Generator',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.botText,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              isChat
                  ? AppStrings.howCanIHelpYou
                  : 'Turn your words into art with AI',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 40),
            _buildQuickActions(chatProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickActions(ChatProvider chatProvider) {
    final actions = chatProvider.currentMode == ChatMode.chat
        ? ['Tell me a joke', 'How does AI work?', 'Write a poem', 'Career advice']
        : [
            'A futuristic city',
            'Cyberpunk cat',
            'Mountain landscape',
            'Space explorer'
          ];
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: actions.map((action) {
        return ActionChip(
          label: Text(action),
          onPressed: () => chatProvider.sendMessage(action),
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
