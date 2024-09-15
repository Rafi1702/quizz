part of 'questions_cubit.dart';

enum QuestionsStatus { initial, loading, success, error }

class QuestionsState extends Equatable {
  const QuestionsState({
    this.duration = 10,
    this.isTimesUp = false,
    this.status = QuestionsStatus.initial,
    this.quiz = const [],
    this.question,
    this.currentIndex = 0,
    this.quizLength = 0,
    this.errorMessage = '',
  });

  final int duration;
  final bool isTimesUp;
  final QuestionsStatus status;
  final List<QuizEntity?> quiz;
  final QuizEntity? question;
  final int currentIndex;
  final int quizLength;
  final String errorMessage;

  QuestionsState copyWith({int? duration,
    bool? isTimesUp,
    QuestionsStatus? status,
    List<QuizEntity?>? quiz,
    QuizEntity? question,
    int? currentIndex,
    int? quizLength,
    String? errorMessage}) =>
      QuestionsState(
        duration: duration ?? this.duration,
        isTimesUp: isTimesUp ?? this.isTimesUp,
        status: status ?? this.status,
        quiz: quiz ?? this.quiz,
        question: question ?? this.question,
        currentIndex: currentIndex ?? this.currentIndex,
        quizLength: quizLength ?? this.quizLength,
        errorMessage: errorMessage ?? this.errorMessage,
      );

  @override
  List<Object?> get props =>
      [
        duration,
        isTimesUp,
        status,
        question,
        currentIndex,
        quizLength,
        errorMessage,
      ];
}
