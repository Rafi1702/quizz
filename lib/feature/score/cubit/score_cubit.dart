import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:quizz/domain/entity/quiz.dart';

part 'score_state.dart';

class ScoreCubit extends Cubit<ScoreState> {
  final List<QuizEntity?> answeredQuestion;

  ScoreCubit({required this.answeredQuestion})
      : super(ScoreState(answeredQuestion: answeredQuestion));

  void countQuizScore() {
    final questions = List<QuizEntity>.from(state.answeredQuestion).map((e) {
      e = e.copyWith(
        correctness: _updateQuestionCorrectness(e),
      );

      return e;
    }).toList();

    return emit(state.copyWith(answeredQuestion: questions));
  }

  //helper
  QuizCorrectness _updateQuestionCorrectness(QuizEntity question) {
    var shouldAnswer = 0;

    var correctness = QuizCorrectness.notCorrect;

    for (int i = 0; i < question.correctAnswers.length; i++) {
      final bool correctCondition = question.correctAnswers[i].isCorrect &&
          question.answers[i].isSelected;
      if (!question.multipleCorrectAnswer) {
        if (correctCondition) {
          correctness = QuizCorrectness.fullCorrect;
        }
      } else {
        if (correctCondition &&
            shouldAnswer >= question.shouldBeAnswerPerQuestion) {
          correctness = QuizCorrectness.fullCorrect;
        } else if (correctCondition) {
          shouldAnswer += 1;
          correctness = QuizCorrectness.halfCorrect;
        }
      }
    }

    return correctness;
  }
}
