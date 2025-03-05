import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';  // Import dotenv

class OpenAIService {
  final String? apiKey = dotenv.env['OPENAI_API_KEY'];  // ✅ Load API key safely

  Future<String> getChatResponse(String userMessage) async {
    if (apiKey == null || apiKey!.isEmpty) {
      return "Error: OPENAI_API_KEY is missing in .env file.";
    }

    const String endpoint = "https://api.openai.com/v1/chat/completions";

    final response = await http.post(
      Uri.parse(endpoint),
      headers: {
        "Authorization": "Bearer $apiKey",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "model": "gpt-3.5-turbo",
        "messages": [
          {"role": "system", "content": "You are a helpful chatbot."},
          {"role": "user", "content": userMessage},
        ],
        "temperature": 0.7
      }),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'];
    } else {
      return "Error: ${response.body}";
    }
  }
}
