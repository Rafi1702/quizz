import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz/domain/model/quiz.dart';
import 'package:quizz/presentation/questions/cubit/questions_cubit.dart';

class QuestionSection extends StatelessWidget {
  const QuestionSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QuestionsCubit, QuestionsState>(
      buildWhen: (prev, curr) => prev.question != curr.question,
      builder: (context, state) {
        return QuizReusable(
          question: state.question,
        );
      },
    );
  }
}

class QuizReusable extends StatelessWidget {
  final Quiz? question;

  const QuizReusable({super.key, required this.question});

  @override
  Widget build(BuildContext context) {
    final currentQuestion = question;
    if (question != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question?.question ?? 'Not Available',
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
          ),
          const SizedBox(height: 40.0),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final answerPerQuestion = currentQuestion?.answers;
              final answer = answerPerQuestion?[index];
              final answerText = answer?.answer;
              final isSelectedAnswer = answer?.isSelected;

              if (answerPerQuestion != null && currentQuestion != null) {
                if (index == currentQuestion.answers.length - 1) {
                  return const Text("Halo");
                }
                if (answerText != null) {
                  return GestureDetector(
                    onTap: () =>
                        context.read<QuestionsCubit>().onAnswerSelected(index),
                    child: AnswerBox(
                      answer: answerText,
                      color: isSelectedAnswer ?? false
                          ? Theme.of(context).colorScheme.onSecondary
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                  );
                }
                return const SizedBox();
              }
              return const SizedBox.shrink();
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10.0),
            itemCount: currentQuestion?.answers.length ?? 0,
          ),
        ],
      );
    }
    return const SizedBox.shrink();
  }
}

class AnswerBox extends StatelessWidget {
  const AnswerBox({super.key, required this.answer, required this.color});

  final String answer;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final answerTextTheme = Theme.of(context).textTheme.bodyLarge!;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: color,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              answer,
              // answer,
              style: color == Theme.of(context).colorScheme.onSurface
                  ? answerTextTheme.copyWith(
                      color: Theme.of(context).colorScheme.onInverseSurface,
                    )
                  : answerTextTheme.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
            ),
          ),
          const Icon(Icons.check_circle),
        ],
      ),
    );
  }
}
