import 'dart:io';

import 'package:quizz/data/datasources/quiz_remote.dart';
import 'package:quizz/data/models/quiz.dart';
import 'package:quizz/domain/model/quiz.dart';

extension on String? {
  bool get getBool {
    switch (this) {
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

  Future<List<Quiz>> getQuiz(
      {required String category, required String difficulty}) async {
    final data =
        await quizApi.getQuiz(category: category, difficulty: difficulty);

    if (data.isEmpty) {
      return Future.error('Data not Available');
    }

    final dtoToModels = data.map((e) {
      return Quiz(
        id: e.id,
        question: e.question,
        multipleCorrectAnswer: e.multipleCorrectAnswers.getBool,
        answers: [
          Answer(answer: e.answers?.answerA),
          Answer(answer: e.answers?.answerB),
          Answer(answer: e.answers?.answerC),
          Answer(answer: e.answers?.answerD),
          Answer(answer: e.answers?.answerE),
          Answer(answer: e.answers?.answerF),
        ],
        correctAnswers: [
          CorrectAnswer(
              isCorrect: e.correctAnswers!.answerACorrect.getBool),
          CorrectAnswer(
              isCorrect: e.correctAnswers!.answerBCorrect.getBool),
          CorrectAnswer(
              isCorrect: e.correctAnswers!.answerCCorrect.getBool),
          CorrectAnswer(
              isCorrect: e.correctAnswers!.answerDCorrect.getBool),
          CorrectAnswer(
              isCorrect: e.correctAnswers!.answerECorrect.getBool),
          CorrectAnswer(
              isCorrect: e.correctAnswers!.answerFCorrect.getBool),
        ],
      );
    }).toList();

    return dtoToModels;
  }
}
