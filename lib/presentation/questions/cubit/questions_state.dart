part of 'questions_cubit.dart';

enum QuestionsStatus { initial, loading, success, error }

@immutable
class QuestionsState extends Equatable {
  const QuestionsState({
    this.isTimesUp = false,
    this.status = QuestionsStatus.initial,
    this.quiz = const [],
    this.question,
    this.currentIndex = 0,
    this.quizLength = 0,
    this.errorMessage = '',
    this.isAllAnswered = false,
    this.shouldBeAnswerPerQuestion = 0,
    this.totalAnsweredByUserPerQuestion = 0,
  });

  final bool isTimesUp;
  final QuestionsStatus status;
  final List<Quiz?> quiz;
  final Quiz? question;
  final int currentIndex;
  final int quizLength;
  final String errorMessage;
  final bool isAllAnswered;
  final int shouldBeAnswerPerQuestion;
  final int totalAnsweredByUserPerQuestion;

  QuestionsState copyWith({
    int? duration,
    bool? isTimesUp,
    QuestionsStatus? status,
    List<Quiz?>? quiz,
    Quiz? question,
    int? currentIndex,
    int? quizLength,
    bool? isAllAnswered,
    String? errorMessage,
    int? shouldBeAnswerPerQuestion,
    int? totalAnsweredByUserPerQuestion,
  }) =>
      QuestionsState(
        isTimesUp: isTimesUp ?? this.isTimesUp,
        status: status ?? this.status,
        quiz: quiz ?? this.quiz,
        question: question ?? this.question,
        currentIndex: currentIndex ?? this.currentIndex,
        quizLength: quizLength ?? this.quizLength,
        errorMessage: errorMessage ?? this.errorMessage,
        isAllAnswered: isAllAnswered ?? this.isAllAnswered,
        shouldBeAnswerPerQuestion:
            shouldBeAnswerPerQuestion ?? this.shouldBeAnswerPerQuestion,
        totalAnsweredByUserPerQuestion: totalAnsweredByUserPerQuestion ??
            this.totalAnsweredByUserPerQuestion,
      );

  @override
  List<Object?> get props => [
        isTimesUp,
        status,
        question,
        currentIndex,
        quizLength,
        errorMessage,
        isAllAnswered,
        shouldBeAnswerPerQuestion,
        totalAnsweredByUserPerQuestion,
      ];
}
