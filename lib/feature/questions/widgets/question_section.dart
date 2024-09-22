import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz/domain/model/quiz.dart';
import 'package:quizz/feature/questions/cubit/questions_cubit.dart';

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
    if (question != null) {
      Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question?.question ?? 'Not Available',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 40.0),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final answers = question?.answers[index];

              if (answers?.answer != null) {
                return GestureDetector(
                  onTap: () =>
                      context.read<QuestionsCubit>().onAnswerSelected(index),
                  child: AnswerBox(
                    answer: answers?.answer ?? 'Unavailable',
                    isSelected: answers?.isSelected ?? false,
                  ),
                );
              }
              return const SizedBox.shrink();
            },
            separatorBuilder: (context, index) => const SizedBox(height: 10.0),
            itemCount: question?.answers.length ?? 0,
          ),
        ],
      );
    }
    return const SizedBox.shrink();
  }
}

class AnswerBox extends StatelessWidget {
  const AnswerBox({super.key, required this.answer, required this.isSelected});

  final String answer;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final answerTextTheme = Theme.of(context).textTheme.bodyLarge!;
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
              style: isSelected
                  ? answerTextTheme.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    )
                  : answerTextTheme.copyWith(
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
