class QuizEntity {
  final int? id;
  final String? question;
  final List<AnswerEntity> answers;
  final List<CorrectAnswersEntity> correctAnswers;
  final bool? multipleCorrectAnswer;
  final bool isAnswered;
  final bool isCorrect;

  const QuizEntity({
    this.id,
    this.question,
    required this.answers,
    required this.correctAnswers,
    this.multipleCorrectAnswer,
    this.isAnswered = false,
    this.isCorrect = false,
  });

  QuizEntity copyWith({
    int? id,
    String? question,
    List<AnswerEntity>? answers,
    List<CorrectAnswersEntity>? correctAnswers,
    bool? multipleCorrectAnswer,
    bool? isAnswered,
  }) {
    return QuizEntity(
      id: id ?? this.id,
      question: question ?? this.question,
      answers: answers ?? this.answers,
      isAnswered: isAnswered??this.isAnswered,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      multipleCorrectAnswer:
          multipleCorrectAnswer ?? this.multipleCorrectAnswer,
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
