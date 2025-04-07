import 'dart:convert';
import 'dart:io';

import 'package:quizz/core/const.dart';
import 'package:quizz/data/api/quiz_api.dart';
import 'package:quizz/data/models/quiz.dart';
import 'package:http/http.dart' as http;

class QuizRemote implements QuizApi {
  final http.BaseClient _client;

  const QuizRemote(this._client);

  @override
  Future<List<QuizDto>> getQuiz(
      {required String category, required String difficulty}) async {
    final response = await _client.get(
      Uri.parse(
          '$url/questions?category=$category&difficulty=$difficulty&limit=7'),
    );

    final decodedResponse = jsonDecode(response.body);

    if (response.statusCode == 200) {
      return (decodedResponse as List).map((e) {
        return QuizDto.fromJson(e);
      }).toList();
    }

    throw HttpException(decodedResponse['error']);
  }
}
