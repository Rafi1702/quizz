part of 'score_cubit.dart';

enum ScoreStatus { initial, loading, success, error }

@immutable
class ScoreState extends Equatable {
  const ScoreState({
    this.answeredQuestion = const [],
    this.status = ScoreStatus.initial,
    this.finalScore = 0.0,
  });

  final List<Quiz?> answeredQuestion;
  final ScoreStatus status;
  final double finalScore;

  ScoreState copyWith(
      {List<Quiz?>? answeredQuestion,
      ScoreStatus? status,
      double? finalScore}) {
    return ScoreState(
      answeredQuestion: answeredQuestion ?? this.answeredQuestion,
      status: status ?? this.status,
      finalScore: finalScore ?? this.finalScore,
    );
  }

  @override
  List<Object?> get props => [answeredQuestion, status, finalScore];
}
