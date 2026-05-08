import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:llm_ai_chat_bot/core/constants/app_strings.dart';
import 'package:llm_ai_chat_bot/core/entities/message_entitie.dart';

import '../../data/model/message_model.dart';
import '../../data/service/api_services.dart';

enum ChatMode { chat, image }

class ChatProvider extends ChangeNotifier {
  ChatProvider({ChatApiServices? chatApiServices})
      : _chatApiServices = chatApiServices ?? ChatApiServices();
  final ChatApiServices _chatApiServices;
  final List<MessageModel> _messages = [];
  bool _isLoading = false;
  String? _errorMessage;
  ChatMode _currentMode = ChatMode.chat;

  List<MessageModel> get messages => List.unmodifiable(_messages);
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  ChatMode get currentMode => _currentMode;

  void setMode(ChatMode mode) {
    _currentMode = mode;
    notifyListeners();
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    if (_currentMode == ChatMode.image) {
      await sendImageRequest(text);
      return;
    }

    _messages
        .add(MessageModel(role: 'user', text: text, timeDate: DateTime.now()));
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final replyText = await _chatApiServices.feachAssitentReply(_messages);
      _messages.add(MessageModel(
          role: 'assistant', text: replyText, timeDate: DateTime.now()));
      _isLoading = false;
      notifyListeners();
    } on TimeoutException {
      _errorMessage = AppStrings.errorTimeout;
    } on SocketException {
      _errorMessage = AppStrings.errorNoInternet;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> sendImageRequest(String prompt) async {
    if (prompt.trim().isEmpty) return;
    _messages.add(MessageModel(
        role: 'user',
        text: 'Generate image: $prompt',
        timeDate: DateTime.now()));
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();
    try {
      final imageUrl = await _chatApiServices.fetchImageGeneration(prompt);
      _messages.add(MessageModel(
          role: 'assistant',
          text: 'Generated Image',
          imageUrl: imageUrl,
          messageType: MessageType.image,
          timeDate: DateTime.now()));
      _isLoading = false;
      notifyListeners();
    } on TimeoutException {
      _errorMessage = AppStrings.errorTimeout;
    } on SocketException {
      _errorMessage = AppStrings.errorNoInternet;
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearChat() {
    _messages.clear();
    _errorMessage = null;
    notifyListeners();
  }
}
