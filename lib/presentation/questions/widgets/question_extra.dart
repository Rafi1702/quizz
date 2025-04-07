import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz/core/extension.dart';
import 'package:quizz/presentation/global_widgets/cubit/app_cubit.dart';
import 'package:quizz/presentation/questions/cubit/questions_cubit.dart';

class QuestionExtra extends StatelessWidget {
  const QuestionExtra({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            QuestionCurrentNumber(),
            TimerBox(),
          ],
        ),
        SizedBox(height: 10.0),
        TotalAnswer(),
      ],
    );
  }
}

class QuestionCurrentNumber extends StatelessWidget {
  const QuestionCurrentNumber({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionsCubit, QuestionsState>(
      buildWhen: (prev, curr) => prev.currentIndex != curr.currentIndex,
      builder: (context, state) {
        return Text(
          'Question: ${state.currentIndex + 1}/${state.quizLength}',
        );
      },
    );
  }
}

class TotalAnswer extends StatelessWidget {
  const TotalAnswer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionsCubit, QuestionsState>(
      buildWhen: (prev, curr) => prev.question != curr.question,
      builder: (context, state) {
        final question = state.question;
        if (question != null) {
          return question.multipleCorrectAnswer
              ? Text(
                  'Multiple Choice: ${question.totalAnsweredByUserPerQuestion}/${question.shouldBeAnswerPerQuestion}')
              : const SizedBox.shrink();
        }
        return const SizedBox.shrink();
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
          BlocSelector<AppCubit, AppState, int>(
            selector: (state) {
              return state.duration;
            },
            builder: (context, state) {
              return Text(
                state.getHourlyFormat,
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
