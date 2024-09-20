import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:quizz/domain/model/quiz.dart';

part 'score_state.dart';

class ScoreCubit extends Cubit<ScoreState> {
  final List<Quiz?> answeredQuestion;

  ScoreCubit({required this.answeredQuestion})
      : super(ScoreState(answeredQuestion: answeredQuestion));

  void countQuizScore() {
    final questions = List<Quiz>.from(state.answeredQuestion).map((question) {
      return question.copyWith(
        correctness: _updateQuestionCorrectness(question),
        scorePoint: countScorePoint(question),
      );
    }).toList();

    return emit(
      state.copyWith(
        answeredQuestion: questions,
        finalScore: countFinalScore(questions),
        totalCorrectAnswer: countTotalCorrectAnswer(questions),
      ),
    );
  }

  //helper
  QuizCorrectness _updateQuestionCorrectness(Quiz question) {
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

  double countScorePoint(Quiz quiz) {
    var score = 0.0;
    for (int i = 0; i < 5; i++) {
      if (quiz.answers[i].isSelected && quiz.correctAnswers[i].isCorrect) {
        if (quiz.multipleCorrectAnswer!) {
          score += 0.5;
        } else {
          score += 1;
        }
      }
    }

    return score;
  }

  int countFinalScore(List<Quiz> questions) {
    var initialValue = 0.0;
    return questions.fold(initialValue,
        (value, e) => value + (e.scorePoint * (100 / questions.length))).floor();
  }

  int countTotalCorrectAnswer(List<Quiz> questions) {
    return questions
        .where((e) => e.correctness == QuizCorrectness.fullCorrect)
        .length;
  }
}
