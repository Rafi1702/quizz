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
      e = updateQuestionCorrectness(e);
      return e;
    }).toList();

    return emit(state.copyWith(answeredQuestion: questions));
  }
}

//helper
QuizEntity updateQuestionCorrectness(QuizEntity question) {
  var temp = question;

  if (!temp.multipleCorrectAnswer!) {
    for (int i = 0; i < temp.correctAnswers.length; i++) {
      if (temp.correctAnswers[i].isCorrect && temp.answers[i].isSelected) {
        temp = temp.copyWith(correctness: QuizCorrectness.fullCorrect);
      }
    }
  }
  else{
    var shouldAnswer = 0;
    for(int i = 0;i<temp.correctAnswers.length;i++){
      bool correctCondition = temp.correctAnswers[i].isCorrect && temp.answers[i].isSelected;
      if(correctCondition && shouldAnswer>=temp.shouldBeAnswerPerQuestion){
        temp = temp.copyWith(correctness: QuizCorrectness.fullCorrect);
      }
      else if(correctCondition){
        shouldAnswer +=1;
        temp = temp.copyWith(correctness: QuizCorrectness.halfCorrect);
      }

    }
  }
  return temp;
}
