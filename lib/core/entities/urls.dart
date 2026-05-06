import 'package:flutter_dotenv/flutter_dotenv.dart';

class Urls {
  static String get baseUrl => dotenv.env['BASE_URL'] ?? '';
  static String get apiKey => dotenv.env['API_KEY'] ?? baseUrl;
  static String get model => dotenv.env['MODEL'] ?? baseUrl;
  static String get apiUrl => dotenv.env['TEST_URL'] ?? baseUrl;
}
