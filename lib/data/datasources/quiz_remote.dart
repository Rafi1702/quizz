import 'dart:convert';
import 'dart:io';

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

  Future<List<QuizDto>> getQuiz(
      {required String category, required String difficulty}) async {
    try {
      final response = await http.get(
          Uri.parse(
              '$url/questions?category=$category&difficulty=$difficulty&limit=5'),
          headers: {
            'x-api-key': key ?? 'none',
          }).timeout(const Duration(seconds: 3));

      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return (decodedResponse as List).map((e) {
          return QuizDto.fromJson(e);
        }).toList();
      }

      throw HttpException(decodedResponse['error']);
    } on SocketException catch (_) {
      throw const SocketException('Check your internet connection');
    }
  }
}
