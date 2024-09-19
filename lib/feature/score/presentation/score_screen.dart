import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz/domain/entity/quiz.dart';
import 'package:quizz/feature/score/cubit/score_cubit.dart';
import 'package:quizz/feature/score/widgets/answered_question.list.dart';

class ScoreScreen extends StatelessWidget {
  static const route = '/score_screen';

  const ScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as List<QuizEntity?>;
    return BlocProvider(
      create: (context) => ScoreCubit(answeredQuestion: arguments),
      child: Scaffold(
        appBar: AppBar(title: const Text('Score')),
        body: const SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Correct Answer: 18/20'),
                      Text('Score: 90')
                    ],
                  ),
                  Divider(
                    thickness: 2.0,
                    color: Colors.white,
                  ),
                  SizedBox(height: 20.0),
                  AnsweredQuestionList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
