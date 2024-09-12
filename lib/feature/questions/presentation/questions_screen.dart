import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz/feature/questions/cubit/questions_cubit.dart';

class QuestionsScreen extends StatelessWidget {
  static const route = '/questions';

  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<QuestionsCubit, QuestionsState>(
          buildWhen: (prev, curr) => prev.status != curr.status,
          builder: (context, state) {
            switch (state.status) {
              case QuestionsStatus.initial:
                return const Center(child: CircularProgressIndicator());
              case QuestionsStatus.success:
                return const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.0,
                    vertical: 10.0,
                  ),
                  child: Column(
                    children: [
                      QuestionExtra(),
                      SizedBox(height: 20.0),
                      QuestionSection(),
                      Spacer(),
                      ChangeQuestionButton(),
                    ],
                  ),
                );
              default:
                return Container();
            }
          },
        ),
      ),
    );
  }
}

class ChangeQuestionButton extends StatelessWidget {
  const ChangeQuestionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final nextButton = ElevatedButton(
        style: const ButtonStyle(
          shape: WidgetStatePropertyAll(
            CircleBorder(),
          ),
        ),
        child: const Icon(Icons.keyboard_arrow_right_rounded),
        onPressed: () {
          context.read<QuestionsCubit>().onQuestionNext();
        });
    final previousButton = ElevatedButton(
        style: const ButtonStyle(
          shape: WidgetStatePropertyAll(
            CircleBorder(),
          ),
        ),
        child: const Icon(Icons.keyboard_arrow_left_rounded),
        onPressed: () {
          context.read<QuestionsCubit>().onQuestionPrevious();
        });
    final submitButton =
        ElevatedButton(child: const Text('Submit'), onPressed: () {});
    return BlocBuilder<QuestionsCubit, QuestionsState>(
      buildWhen: (prev, curr) =>
          prev.currentIndex != curr.currentIndex ||
          prev.quizLength != curr.quizLength,
      builder: (context, state) {
        if (state.currentIndex == 0) {
          return Align(
            alignment: Alignment.bottomRight,
            child: nextButton,
          );
        } else if (state.currentIndex + 1 == state.quizLength) {
          return Row(

            children: [
              previousButton,
              const SizedBox(width: 10.0),
              Expanded(flex: 3,child: submitButton),
              const Spacer(),
            ],
          );
        } else {
          return Row(
            children: [const Spacer(), previousButton, nextButton],
          );
        }
      },
    );
  }
}

class QuestionSection extends StatelessWidget {
  const QuestionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionsCubit, QuestionsState>(
      buildWhen: (prev, curr) => prev.question != curr.question,
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              state.question!.question ?? 'Not Available',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 40.0),
            ListView.separated(
              clipBehavior: Clip.none,
              shrinkWrap: true,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () =>
                    context.read<QuestionsCubit>().onAnswerSelected(index),
                child: AnswerBox(
                  answer:
                      state.question?.answers?[index]?.answer ?? 'Unavailable',
                  isSelected:
                      state.question?.answers?[index]?.isSelected ?? false,
                ),
              ),
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 10.0),
              itemCount: state.question!.answers!.length,
            ),
          ],
        );
      },
    );
  }
}

class AnswerBox extends StatelessWidget {
  const AnswerBox({super.key, required this.answer, required this.isSelected});

  final String answer;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: isSelected
            ? Colors.purple
            : Theme.of(context).colorScheme.onSurface,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              answer,
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onInverseSurface,
                  ),
            ),
          ),
          const Icon(Icons.check_circle),
        ],
      ),
    );
  }
}

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
