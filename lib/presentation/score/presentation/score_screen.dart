import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:quizz/presentation/questions/barrel.dart';
import 'package:quizz/presentation/score/cubit/score_cubit.dart';
import 'package:quizz/presentation/score/widgets/answered_question.list.dart';
import 'package:quizz/presentation/score/widgets/total_score.dart';

class ScoreScreen extends StatelessWidget {
  static const route = '/score_screen';

  const ScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as ScoreScreenArgument;
    return BlocProvider(
      create: (context) =>
          ScoreCubit(answeredQuestion: arguments.answeredQuestion)
            ..countQuizScore(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Score')),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Builder(builder: (context) {
                    return IconButton(
                      icon: const Icon(Icons.refresh_rounded),
                      onPressed: () =>
                          context.read<ScoreCubit>()..countQuizScore(),
                    );
                  }),
                  const TotalScore(),
                  const Divider(
                    thickness: 2.0,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 20.0),
                  const AnsweredQuestionList(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
