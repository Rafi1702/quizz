import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz/feature/questions/cubit/questions_cubit.dart';

class QuestionsScreen extends StatelessWidget {
  static const route = '/questions';

  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Questions')),
      body: BlocBuilder<QuestionsCubit, QuestionsState>(
        buildWhen: (prev, curr) => prev.status != curr.status,
        builder: (context, state) {
          switch (state.status) {
            case QuestionsStatus.initial:
              return const Center(child: CircularProgressIndicator());
            case QuestionsStatus.success:
              return const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    HeaderSection(),
                    SizedBox(height: 20.0),
                    QuizSection(),
                    Spacer(),
                  ],
                ),
              );
            default:
              return Container();
          }
        },
      ),
    );
  }
}

class QuizSection extends StatelessWidget {
  const QuizSection({super.key});

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
              textAlign: TextAlign.center,
              state.question!.question ?? 'Not Available',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 40.0),
            ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) => GestureDetector(
                onTap: () =>
                    context.read<QuestionsCubit>().onAnswerSelected(index),
                child: AnswerBox(
                  answer: state.question?.answers?.answers[index].answer ??
                      'Unavailable',
                  isSelected: state.question?.answers?.answers[index].isSelected??false,
                ),
              ),
              separatorBuilder: (context, index) =>
                  const SizedBox(height: 10.0),
              itemCount: state.question!.answers!.answers!.length,
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
        color: isSelected? Colors.purple:Theme.of(context).colorScheme.onSurface,
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

class HeaderSection extends StatelessWidget {
  const HeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
          child: const Icon(Icons.close),
          onTap: () {},
        ),
        const QuestionNumberBox(),
        const TimerBox(),
      ],
    );
  }
}

class QuestionNumberBox extends StatelessWidget {
  const QuestionNumberBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: Text(
          '1',
          style:
              TextStyle(color: Theme.of(context).colorScheme.onInverseSurface),
        ),
      ),
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
