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
      for (int i = 0; i < e!.correctAnswers.length; i++) {
        if (e.correctAnswers[i].isCorrect && e.answers[i].isSelected) {
          e = e.copyWith(correctness: QuizCorrectness.fullCorrect);
        } else {
          e = e.copyWith(correctness: QuizCorrectness.fullCorrect);
        }
      }
      return e;
    }).toList();

    return emit(state.copyWith(answeredQuestion: questions));
  }
}

//helper
List<QuizEntity?> correctnessUpdate(List<QuizEntity?> answeredQuestion) {
  var temp = answeredQuestion;
  for (var e in temp) {
    for (int i = 0; i < e!.correctAnswers.length; i++) {
      if (e.correctAnswers[i].isCorrect && e.answers[i].isSelected) {
        e.copyWith(correctness: QuizCorrectness.fullCorrect);
      } else {
        e.copyWith(correctness: QuizCorrectness.notCorrect);
      }
    }
  }
  return temp;
}
