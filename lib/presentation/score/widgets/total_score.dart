import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz/presentation/score/cubit/score_cubit.dart';

class TotalScore extends StatelessWidget {
  const TotalScore({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScoreCubit, ScoreState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
                'Correct Answer: ${state.totalCorrectAnswer}/${state.answeredQuestion.length}'),
            Text('Score: ${state.finalScore}'),
          ],
        );
      },
    );
  }
}
