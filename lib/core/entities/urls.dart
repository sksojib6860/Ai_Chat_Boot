import 'package:flutter_dotenv/flutter_dotenv.dart';

class Urls {
  static String get baseUrl => dotenv.env['BASE_URL'] ?? '';
  static String get apiKey => dotenv.env['API_KEY'] ?? '';
  static String get model => dotenv.env['MODEL'] ?? 'gpt-3.5-turbo';
  static String get apiUrl => dotenv.env['TEST_URL'] ?? baseUrl;
  static String get imageGenUrl =>
      dotenv.env['IMAGE_GEN_URL'] ??
      'https://api.openai.com/v1/images/generations';
  static String get imageModel => dotenv.env['IMAGE_MODEL'] ?? 'dall-e-2';
  static String get openaiApiKey => dotenv.env['OPENAI_API_KEY'] ?? '';
}
