part of 'questions_cubit.dart';

enum QuestionsStatus { initial, loading, success, error }

@immutable
class QuestionsState extends Equatable {
  const QuestionsState(
      {this.duration = 3600,
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
      this.fixedQuiz = const []});

  final int duration;
  final bool isTimesUp;
  final QuestionsStatus status;
  final List<QuizEntity?> quiz;
  final List<QuizEntity?> fixedQuiz;
  final QuizEntity? question;
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
    List<QuizEntity?>? quiz,
    QuizEntity? question,
    int? currentIndex,
    int? quizLength,
    bool? isAllAnswered,
    String? errorMessage,
    int? shouldBeAnswerPerQuestion,
    int? totalAnsweredByUserPerQuestion,
    List<QuizEntity?>? fixedQuiz,
  }) =>
      QuestionsState(
        duration: duration ?? this.duration,
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
        fixedQuiz: fixedQuiz ?? this.fixedQuiz,
      );

  @override
  List<Object?> get props => [
        duration,
        isTimesUp,
        status,
        question,
        currentIndex,
        quizLength,
        errorMessage,
        isAllAnswered,
        shouldBeAnswerPerQuestion,
        totalAnsweredByUserPerQuestion,
        fixedQuiz,
      ];
}
