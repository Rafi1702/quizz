enum QuizCorrectness {
  notCorrect,
  halfCorrect,
  fullCorrect,
}

class Quiz {
  final int? id;
  final String? question;
  final List<Answer> answers;
  final List<CorrectAnswer> correctAnswers;
  final bool multipleCorrectAnswer;
  final bool isAnswered;

  //added properties/field
  final QuizCorrectness correctness;
  final int shouldBeAnswerPerQuestion;
  final int totalAnsweredByUserPerQuestion;
  final double scorePoint;

  const Quiz({
    this.id,
    this.question,
    required this.answers,
    required this.correctAnswers,
    this.multipleCorrectAnswer = false,
    this.isAnswered = false,
    this.correctness = QuizCorrectness.notCorrect,
    this.shouldBeAnswerPerQuestion = 0,
    this.totalAnsweredByUserPerQuestion = 0,
    this.scorePoint = 0.0,
  });

  Quiz copyWith({
    int? id,
    String? question,
    List<Answer>? answers,
    List<CorrectAnswer>? correctAnswers,
    bool? multipleCorrectAnswer,
    bool? isAnswered,
    QuizCorrectness? correctness,
    int? shouldBeAnswerPerQuestion,
    int? totalAnsweredByUserPerQuestion,
    double? scorePoint,
  }) {
    return Quiz(
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
      scorePoint: scorePoint??this.scorePoint,
    );
  }
}

class Answer {
  const Answer({this.answer, this.isSelected = false});

  final String? answer;
  final bool isSelected;

  Answer copyWith({String? answer, bool? isSelected}) => Answer(
      answer: answer ?? this.answer, isSelected: isSelected ?? this.isSelected);
}

class CorrectAnswer {
  final bool isCorrect;

  const CorrectAnswer({this.isCorrect = false});
}
