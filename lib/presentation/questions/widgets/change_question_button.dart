import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz/domain/model/quiz.dart';
import 'package:quizz/presentation/questions/cubit/questions_cubit.dart';
import 'package:quizz/presentation/score/presentation/score_screen.dart';

class ScoreScreenArgument {
  final List<Quiz?> answeredQuestion;

  const ScoreScreenArgument({required this.answeredQuestion});
}

class ChangeQuestionButton extends StatelessWidget {
  const ChangeQuestionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final nextButton = FilledButton(
        style: const ButtonStyle(
          shape: WidgetStatePropertyAll(
            CircleBorder(),
          ),
        ),
        child: const Icon(
          Icons.keyboard_arrow_right_rounded,
        ),
        onPressed: () {
          context
              .read<QuestionsCubit>()
              .onQuestionNextOrPrevious((currentIndex) => currentIndex + 1);
        });
    final previousButton = FilledButton(
        style: const ButtonStyle(
          shape: WidgetStatePropertyAll(
            CircleBorder(),
          ),
        ),
        child: const Icon(
          Icons.keyboard_arrow_left_rounded,
        ),
        onPressed: () {
          context
              .read<QuestionsCubit>()
              .onQuestionNextOrPrevious((currentIndex) => currentIndex - 1);
        });

    return BlocBuilder<QuestionsCubit, QuestionsState>(
      buildWhen: (prev, curr) =>
          prev.currentIndex != curr.currentIndex ||
          prev.question != curr.question,
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
              Expanded(
                flex: 3,
                child: ElevatedButton(
                  onPressed: state.isAllAnswered
                      ? () {
                          Navigator.of(context)
                              .pushReplacementNamed(ScoreScreen.route,
                                  arguments: ScoreScreenArgument(
                                    answeredQuestion: state.quiz,
                                  ));
                        }
                      : null,
                  child: const Text('Submit'),
                ),
              ),
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
