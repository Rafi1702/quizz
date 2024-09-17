import 'dart:io';

import 'package:quizz/data/datasources/quiz_remote.dart';
import 'package:quizz/data/models/quiz.dart';
import 'package:quizz/domain/entity/quiz.dart';

extension on String?{
  bool get getBool{
    switch(this){
      case "true":
        return true;
      default:
        return false;
    }


  }
}
class QuizRepository {
  final QuizApi quizApi;

  const QuizRepository(this.quizApi);

  Future<List<QuizEntity>> getQuiz(
      {required String category, required String difficulty}) async {
    try {
      final data =
          await quizApi.getQuiz(category: category, difficulty: difficulty);

      final dtoToEntity = data.map((e) {
        return QuizEntity(
          id: e.id,
          question: e.question,
          multipleCorrectAnswer: e.multipleCorrectAnswers.getBool,
          answers: [
            AnswerEntity(answer: e.answers?.answerA),
            AnswerEntity(answer: e.answers?.answerB),
            AnswerEntity(answer: e.answers?.answerC),
            AnswerEntity(answer: e.answers?.answerD)
          ],
          correctAnswers: [
            CorrectAnswersEntity(isCorrect: e.correctAnswers?.answerACorrect.getBool),
            CorrectAnswersEntity(isCorrect: e.correctAnswers?.answerBCorrect.getBool),
            CorrectAnswersEntity(isCorrect: e.correctAnswers?.answerCCorrect.getBool),
            CorrectAnswersEntity(isCorrect: e.correctAnswers?.answerDCorrect.getBool),
          ],
        );
      }).toList();

      return dtoToEntity;
    } catch (e) {
      throw Exception(e);
    }
  }
}
