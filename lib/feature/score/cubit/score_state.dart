part of 'score_cubit.dart';

enum ScoreStatus { initial, loading, success, error }

@immutable
class ScoreState extends Equatable {
  const ScoreState({
    this.answeredQuestion = const [],
    this.status = ScoreStatus.initial,
    this.finalScore = 0,
    this.totalCorrectAnswer = 0,
  });

  final List<Quiz?> answeredQuestion;
  final ScoreStatus status;
  final int finalScore;
  final int totalCorrectAnswer;

  ScoreState copyWith({List<Quiz?>? answeredQuestion,
    ScoreStatus? status,
    int? finalScore,
    int? totalCorrectAnswer}) {
    return ScoreState(
      answeredQuestion: answeredQuestion ?? this.answeredQuestion,
      status: status ?? this.status,
      finalScore: finalScore ?? this.finalScore,
      totalCorrectAnswer: totalCorrectAnswer ?? this.totalCorrectAnswer,
    );
  }

  @override
  List<Object?> get props => [answeredQuestion, status, finalScore, totalCorrectAnswer];
}
