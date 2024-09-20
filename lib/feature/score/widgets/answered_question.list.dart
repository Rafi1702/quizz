import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz/domain/entity/quiz.dart';
import 'package:quizz/feature/score/cubit/score_cubit.dart';
import 'package:quizz/feature/score/presentation/question_review_screen.dart';

class AnsweredQuestionList extends StatelessWidget {
  const AnsweredQuestionList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScoreCubit, ScoreState>(builder: (context, state) {
      return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemBuilder: (context, index) {
            final answeredQuestion = state.answeredQuestion[index];
            return GestureDetector(
              onTap:(){
                Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                    QuestionReviewScreen(answeredQuestion: answeredQuestion),
                ));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 10.0,
                    child: Center(
                      child: FittedBox(
                          fit: index > 9 ? BoxFit.scaleDown : BoxFit.none,
                          child: Text('${index + 1}.')),
                    ),
                  ),
                  Text(answeredQuestion!.isAnswered ? 'Answered' : 'Not Answered'),
                  correctness(answeredQuestion.correctness, context),
                ],
              ),
            );
          },
          separatorBuilder: (context, index) => const Divider(height: 50),
          itemCount: state.answeredQuestion.length);
    });
  }

  Icon correctness(QuizCorrectness correctness, BuildContext context){
    switch(correctness){
      case QuizCorrectness.fullCorrect:
       return Icon(Icons.check_circle, color: Theme.of(context).colorScheme.onSecondary);
      case QuizCorrectness.notCorrect:
        return Icon(Icons.close_rounded, color: Theme.of(context).colorScheme.onError);
      case QuizCorrectness.halfCorrect:
        return const Icon(Icons.warning_rounded, color: Colors.amber);
    }

  }
}
