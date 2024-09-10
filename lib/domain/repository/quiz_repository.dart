import 'package:quizz/data/datasources/quiz_remote.dart';
import 'package:quizz/data/models/quiz.dart';
import 'package:quizz/domain/entity/quiz.dart';

class QuizRepository {
  final QuizApi quizApi;

  const QuizRepository(this.quizApi);

  Future<List<QuizEntity>> getQuiz() async {
    try {
      final data = await quizApi.getQuiz();

      final dtoToEntity = data.map((e) {
        return QuizEntity(
          id: e.id,
          question: e.question,
          answers: AnswersEntity(answers: [
            AnswerEntity(answer: e.answers?.answerA),
            AnswerEntity(answer: e.answers?.answerB),
            AnswerEntity(answer: e.answers?.answerC),
            AnswerEntity(answer: e.answers?.answerD)
          ]),
          correctAnswers: CorrectAnswersEntity(
            answerACorrect: e.correctAnswers?.answerACorrect,
            answerBCorrect: e.correctAnswers?.answerBCorrect,
            answerCCorrect: e.correctAnswers?.answerCCorrect,
            answerDCorrect: e.correctAnswers?.answerDCorrect,
          ),
        );
      }).toList();
      print(dtoToEntity);
      return dtoToEntity;
    } catch (e) {
      throw Exception(e);
    }
  }
}
