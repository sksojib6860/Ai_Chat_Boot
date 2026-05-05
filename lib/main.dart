import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'core/chat_bot_app.dart';

Future<void> main() async {
  await dotenv.load();
  runApp(const ChatBotApp());
}
