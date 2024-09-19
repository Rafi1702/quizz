import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz/feature/questions/cubit/questions_cubit.dart';

class NumberList extends StatefulWidget {
  const NumberList({super.key});

  @override
  State<NumberList> createState() => _NumberListState();
}

class _NumberListState extends State<NumberList> {
  final _scrollController = ScrollController();

  void _animateToIndex(int index, double width) {
    _scrollController.animateTo(
      index * width,
      duration: const Duration(milliseconds: 500),
      curve: Curves.fastOutSlowIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.0,
      child: ListView.separated(
        itemCount: 20,
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        separatorBuilder: (context, index) => const SizedBox(width: 10.0),
        itemBuilder: (context, index) {
          return BlocListener<QuestionsCubit, QuestionsState>(
            listenWhen: (prev, curr) => prev.question != curr.question,
            listener: (context, state) {
              _animateToIndex(state.currentIndex, 70.0);
            },
            child: BlocBuilder<QuestionsCubit, QuestionsState>(
              buildWhen: (prev, curr) => prev.currentIndex != curr.currentIndex,
              builder: (context, state) {
                return GestureDetector(
                  onTap: () => context
                      .read<QuestionsCubit>()
                      .onQuestionNextOrPrevious((_) => index),
                  child: Container(
                    width: 60.0,
                    decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.0,
                            color: state.quiz[index]!.isAnswered!
                                ? Colors.red
                                : Colors.transparent),
                        borderRadius: BorderRadius.circular(8.0),
                        color: state.currentIndex == index
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onSurface),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: Theme.of(context)
                            .textTheme
                            .headlineMedium!
                            .copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onInverseSurface,
                            ),
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
