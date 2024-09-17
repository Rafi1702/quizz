class QuizEntity {
  final int? id;
  final String? question;
  final List<AnswerEntity>? answers;
  final List<CorrectAnswersEntity>? correctAnswers;
  final bool? multipleCorrectAnswer;

  const QuizEntity(
      {this.id,
      this.question,
      this.answers,
      this.correctAnswers,
      this.multipleCorrectAnswer});

  QuizEntity copyWith({
    int? id,
    String? question,
    List<AnswerEntity>? answers,
    List<CorrectAnswersEntity>? correctAnswers,
    bool? multipleCorrectAnswer,
  }) {
    return QuizEntity(
      id: id ?? this.id,
      question: question ?? this.question,
      answers: answers ?? this.answers,
      correctAnswers: correctAnswers ?? this.correctAnswers,
      multipleCorrectAnswer:
          multipleCorrectAnswer ?? this.multipleCorrectAnswer,
    );
  }
}

class AnswerEntity {
  const AnswerEntity({this.answer, this.isSelected = false});

  final String? answer;
  final bool? isSelected;

  AnswerEntity copyWith({String? answer, bool? isSelected}) => AnswerEntity(
      answer: answer ?? this.answer, isSelected: isSelected ?? this.isSelected);
}

class CorrectAnswersEntity {
  final bool? isCorrect;

  const CorrectAnswersEntity({required this.isCorrect});
}
