import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz/feature/questions/cubit/questions_cubit.dart';

class QuestionExtra extends StatelessWidget {
  const QuestionExtra({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        QuestionCurrentNumber(),
        TimerBox(),
      ],
    );
  }
}

class QuestionCurrentNumber extends StatelessWidget {
  const QuestionCurrentNumber({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionsCubit, QuestionsState>(
      buildWhen: (prev, curr) =>
          prev.currentIndex != curr.currentIndex ||
          prev.quizLength != curr.quizLength,
      builder: (context, state) {
        return Text(
          'Question: ${state.currentIndex + 1}/${state.quizLength}',
        );
      },
    );
  }
}

class TimerBox extends StatelessWidget {
  const TimerBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.timer_rounded,
              color: Theme.of(context).colorScheme.onInverseSurface),
          BlocSelector<QuestionsCubit, QuestionsState, int>(
            selector: (state) {
              // TODO: return selected state
              return state.duration;
            },
            builder: (context, state) {
              String minute =
                  ((state / 60) % 60).floor().toString().padLeft(2, '0');
              String seconds = (state % 60).floor().toString().padLeft(2, '0');
              return Text(
                '$minute:$seconds',
                style: TextStyle(
                    color: Theme.of(context).colorScheme.onInverseSurface),
              );
            },
          ),
        ],
      ),
    );
  }
}
