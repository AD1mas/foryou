import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

import 'supabase_service.dart';

class AIService {
  AIService() {
    dotenv.load(fileName: ".env");
  }

  Future<void> getResponse(String prompt) async {
    final url = Uri.parse(dotenv.get("API_BASE_URL"));
    SupabaseService().saveMessage("user", prompt);
    try {
      final response = await post(
        url,
        headers: {"Content-Type": "application/json"},
        body: '{"text": "$prompt"}',
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        SupabaseService().saveMessage("assistant", data['response']['content']);
      } else {
        throw Exception("Failed to get AI response");
      }
    } catch (e) {
      throw Exception("Failed to send AI response");
    }
  }
}
