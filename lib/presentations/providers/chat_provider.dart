import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:llm_ai_chat_bot/core/constants/app_strings.dart';
import 'package:llm_ai_chat_bot/data/service/api_services.dart';

import '../../data/model/message_model.dart';

class ChatProvider extends ChangeNotifier {
  ChatProvider({ChatApiServices? chatApiServices})
      : _chatApiServices = chatApiServices ?? ChatApiServices();
  final ChatApiServices _chatApiServices;
  final List<MessageModel> _messages = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<MessageModel> get messages => List.unmodifiable(_messages);
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;
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
      _errorMessage = AppStrings.errorGeneral;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
    void clearChat() {
      _messages.clear();
      _errorMessage = null;
      notifyListeners();
    }
  }
}
//TODO: 1.3 minutes running and url isLoading:https://ostad.app/dashboard/my-courses/682a82776a5bde5a54e7d2ae/recordings?play=69ee514d71f1ae268393dbb8
