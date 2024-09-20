import 'package:flutter/material.dart';
import 'package:quizz/domain/entity/quiz.dart';

class QuestionReviewScreen extends StatelessWidget {
  final QuizEntity answeredQuestion;

  const QuestionReviewScreen({
    super.key,
    required this.answeredQuestion,
  });

  @override
  Widget build(BuildContext context) {
    final answerTextTheme = Theme.of(context).textTheme.bodyLarge!;
    return Scaffold(
        appBar: AppBar(title: const Text('Question Review')),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(answeredQuestion.question!),
              ListView.separated(
                shrinkWrap: true,
                itemCount: answeredQuestion.answers.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10.0),
                itemBuilder: (context, index) {
                  print(answeredQuestion.correctAnswers[index].isCorrect);
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: answerBoxColor(answeredQuestion.answers[index],
                            answeredQuestion.correctAnswers[index], context)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            answeredQuestion.answers[index].answer ??
                                'Not Available',
                            style: answeredQuestion.answers[index].isSelected ||
                                    answeredQuestion
                                        .correctAnswers[index].isCorrect
                                ? answerTextTheme.copyWith(
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
                                  )
                                : answerTextTheme.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onInverseSurface,
                                  ),
                          ),
                        ),
                        const Icon(Icons.check_circle),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
        ));
  }

  Color answerBoxColor(AnswerEntity answer, CorrectAnswersEntity correctAnswer,
      BuildContext context) {
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
