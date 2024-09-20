enum QuizCorrectness {
  notCorrect,
  halfCorrect,
  fullCorrect,
}

class QuizEntity {
  final int? id;
  final String? question;
  final List<AnswerEntity> answers;
  final List<CorrectAnswersEntity> correctAnswers;
  final bool? multipleCorrectAnswer;
  final bool isAnswered;
  final QuizCorrectness correctness;
  final int shouldBeAnswerPerQuestion;
  final int totalAnsweredByUserPerQuestion;

  const QuizEntity({
    this.id,
    this.question,
    required this.answers,
    required this.correctAnswers,
    this.multipleCorrectAnswer,
    this.isAnswered = false,
    this.correctness = QuizCorrectness.notCorrect,
    this.shouldBeAnswerPerQuestion = 0,
    this.totalAnsweredByUserPerQuestion = 0,
  });

  QuizEntity copyWith({
    int? id,
    String? question,
    List<AnswerEntity>? answers,
    List<CorrectAnswersEntity>? correctAnswers,
    bool? multipleCorrectAnswer,
    bool? isAnswered,
    QuizCorrectness? correctness,
    int? shouldBeAnswerPerQuestion,
    int? totalAnsweredByUserPerQuestion,
  }) {
    return QuizEntity(
      id: id ?? this.id,
      question: question ?? this.question,
      answers: answers ?? this.answers,
      isAnswered: isAnswered ?? this.isAnswered,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      multipleCorrectAnswer:
          multipleCorrectAnswer ?? this.multipleCorrectAnswer,
      correctness: correctness ?? this.correctness,
      shouldBeAnswerPerQuestion: shouldBeAnswerPerQuestion??this.shouldBeAnswerPerQuestion,
      totalAnsweredByUserPerQuestion: totalAnsweredByUserPerQuestion??this.totalAnsweredByUserPerQuestion,
    );
  }
}

class AnswerEntity {
  const AnswerEntity({this.answer, this.isSelected = false});

  final String? answer;
  final bool isSelected;

  AnswerEntity copyWith({String? answer, bool? isSelected}) => AnswerEntity(
      answer: answer ?? this.answer, isSelected: isSelected ?? this.isSelected);
}

class CorrectAnswersEntity {
  final bool isCorrect;

  const CorrectAnswersEntity({this.isCorrect = false});
}
