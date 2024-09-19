import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:quizz/domain/entity/quiz.dart';

part 'score_state.dart';

class ScoreCubit extends Cubit<ScoreState> {
  final List<QuizEntity?> answeredQuestion;
  final List<QuizEntity?> actualQuiz;

  ScoreCubit({required this.answeredQuestion, required this.actualQuiz})
      : super(ScoreState(answeredQuestion: answeredQuestion));

  void getQuizScore() {}
}
