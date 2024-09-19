import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz/feature/score/cubit/score_cubit.dart';

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
            return Row(
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
                const SizedBox.shrink(),
              ],
            );
          },
          separatorBuilder: (context, index) => const Divider(height: 50),
          itemCount: state.answeredQuestion.length);
    });
  }
}
