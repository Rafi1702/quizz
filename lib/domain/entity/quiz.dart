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
  AnswersEntity copyWith({List<AnswerEntity>? answers}){
    return AnswersEntity(answers: answers??this.answers);
  }
  //
  // const AnswersEntity(
  //     {required this.answerA,
  //     required this.answerB,
  //     required this.answerC,
  //     required this.answerD});
  //
  // AnswersEntity copyWith(AnswerEntity? answerA, AnswerEntity? answerB,
  //     AnswerEntity? answerC, AnswerEntity? answerD) {
  //   return AnswersEntity(
  //     answerA: answerA ?? this.answerA,
  //     answerB: answerB ?? this.answerB,
  //     answerC: answerC ?? this.answerC,
  //     answerD: answerD ?? this.answerD,
  //   );
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
