import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static initEnvironment() async {
    await dotenv.load(fileName: '.env');
  }

  static String baseURL =
      dotenv.env['BASE_URL'] ?? 'Base url is not configured';
  static String get cloudName =>
      dotenv.env['CLOUD_NAME'] ?? 'Cloud name not configured';
  static String get apiKey => dotenv.env['API_KEY'] ?? 'API Key not configured';
  static String get apiSecret =>
      dotenv.env['API_SECRET'] ?? 'API Secret not configured';
}
