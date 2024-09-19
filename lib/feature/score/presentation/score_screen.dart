import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz/feature/score/cubit/score_cubit.dart';

class ScoreScreen extends StatelessWidget {
  static const route = '/score_screen';

  const ScoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ScoreCubit(),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Center(
                    child: Text('Final Score',
                        style: Theme.of(context).textTheme.headlineLarge)),
                const SizedBox(height: 20.0),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Correct Answer: 18/20'), Text('Score: 90')],
                ),
                const Divider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
