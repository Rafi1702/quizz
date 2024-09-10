import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:quizz/data/models/quiz.dart';
import 'package:http/http.dart' as http;

class QuizApi {
  late String? key;
  late String? url;

  QuizApi() {
    key = dotenv.env['API_KEY'];
    url = dotenv.env['API_URL'];
  }

  Future<List<QuizDto>> getQuiz() async {

    try {
      final response = await http.get(Uri.parse('$url/questions'), headers: {
        'x-api-key': key ?? 'none',
      });
      return (jsonDecode(response.body) as List).map((e){
        return QuizDto.fromJson(e);
      }).toList();
    } catch (e) {
      throw Exception(e);
    }
  }
}
