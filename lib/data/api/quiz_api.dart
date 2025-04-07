import 'package:quizz/data/models/quiz.dart';

abstract interface class QuizApi {
  Future<List<QuizDto>> getQuiz(
      {required String category, required String difficulty});
}
