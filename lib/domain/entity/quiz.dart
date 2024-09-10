class QuizEntity {
  final int? id;
  final String? question;
  final AnswersEntity? answers;
  final CorrectAnswersEntity? correctAnswers;

  const QuizEntity({this.id, this.question, this.answers, this.correctAnswers});

  QuizEntity copyWith(
      {int? id,
      String? question,
      AnswersEntity? answers,
      CorrectAnswersEntity? correctAnswers}) {
    return QuizEntity(
        id: id ?? this.id,
        question: question ?? this.question,
        answers: answers ?? this.answers,
        correctAnswers: correctAnswers ?? this.correctAnswers);
  }
}

class AnswersEntity {
  final List<AnswerEntity> answers;

  const AnswersEntity({required this.answers});

  AnswersEntity copyWith({List<AnswerEntity>? answers}) {
    return AnswersEntity(answers: answers ?? this.answers);
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
  final String? answerACorrect;
  final String? answerBCorrect;
  final String? answerCCorrect;
  final String? answerDCorrect;

  const CorrectAnswersEntity(
      {this.answerACorrect,
      this.answerBCorrect,
      this.answerCCorrect,
      this.answerDCorrect});
}
