import 'package:flutter/material.dart';
import 'package:quizz/domain/model/quiz.dart';
import 'package:quizz/feature/questions/barrel.dart';

class QuestionReviewScreen extends StatelessWidget {
  final Quiz answeredQuestion;

  const QuestionReviewScreen({
    super.key,
    required this.answeredQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Question Review')),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(answeredQuestion.question!),
              QuizReusable(question: answeredQuestion),
            ],
          ),
        ));
  }

  Color answerBoxColor(
      Answer answer, CorrectAnswer correctAnswer, BuildContext context) {
    if (answer.isSelected) {
      if (answer.isSelected && correctAnswer.isCorrect) {
        return Colors.purple;
      }
      return Colors.red;
    } else if (correctAnswer.isCorrect) {
      return Colors.green;
    } else {
      return Theme.of(context).colorScheme.onSurface;
    }
  }
}
