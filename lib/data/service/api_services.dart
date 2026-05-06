import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:llm_ai_chat_bot/core/constants/app_strings.dart';
import 'package:llm_ai_chat_bot/data/model/message_model.dart';

import '../../core/entities/urls.dart';

class ChatApiServices {
  Future<String> feachAssitentReply(List<MessageModel> messages) async {
    final response = await http
        .post(Uri.parse(Urls.baseUrl),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': Urls.apiKey,
            },
            body: jsonEncode(
              {
                'model': Urls.model,
                "max_tokens": 500,
                "messages": [
                  {"role": "user", "content": AppStrings.systemPrompt},
                  ...messages.map((message) => message.toApiMap()),
                ]
              },
            ))
        .timeout(Duration(seconds: 30));
    if (response.statusCode != 200) {
      throw Exception(
          'Failed to fetch data from the API. Status code: ${response.statusCode}');
    }
    final data = jsonDecode(response.body);
    return (data['choices'][0]['message']['content'] as String).trim();
  }
}
