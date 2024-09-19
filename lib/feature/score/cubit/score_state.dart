part of 'score_cubit.dart';

enum ScoreStatus { initial, loading, success, error }

@immutable
class ScoreState extends Equatable {
  const ScoreState(
      {this.answeredQuestion = const [], this.status = ScoreStatus.initial});

  final List<QuizEntity?> answeredQuestion;
  final ScoreStatus status;

  ScoreState copyWith(
      {List<QuizEntity?>? answeredQuestion, ScoreStatus? status}) {
    return ScoreState(
        answeredQuestion: answeredQuestion ?? this.answeredQuestion,
        status: status ?? this.status);
  }

  @override
  List<Object?> get props => [answeredQuestion, status];
}
