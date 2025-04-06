import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz/presentation/questions/cubit/questions_cubit.dart';

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
    const containerWidth = 60.0;
    const spaceBetweenContainer = 10.0;
    return BlocListener<QuestionsCubit, QuestionsState>(
      listenWhen: (prev, curr) => prev.currentIndex != curr.currentIndex,
      listener: (context, state) {
        _animateToIndex(
            state.currentIndex, containerWidth + spaceBetweenContainer);
      },
      child: BlocBuilder<QuestionsCubit, QuestionsState>(
        buildWhen: (prev, curr) => prev.question != curr.question,
        builder: (context, state) {
          return SizedBox(
            height: 60.0,
            child: ListView.separated(
              itemCount: state.quiz.length,
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (context, index) =>
                  const SizedBox(width: spaceBetweenContainer),
              itemBuilder: (context, index) {
                final isCurrentIndexEqualIndex = state.currentIndex == index;

                final isAnswered = state.quiz[index]!.isAnswered;
                return GestureDetector(
                  onTap: () => context
                      .read<QuestionsCubit>()
                      .onQuestionNextOrPrevious((_) => index),
                  child: Container(
                    width: containerWidth,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        color: state.currentIndex == index
                            ? Theme.of(context).colorScheme.primary
                            : Theme.of(context).colorScheme.onSurface),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '${index + 1}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium!
                              .copyWith(
                                fontWeight: isCurrentIndexEqualIndex
                                    ? FontWeight.w900
                                    : null,
                                color: isCurrentIndexEqualIndex
                                    ? Colors.white
                                    : Theme.of(context)
                                        .colorScheme
                                        .onInverseSurface,
                              ),
                        ),
                        isAnswered
                            ? Expanded(
                                child: Container(
                                  width: 10.0,
                                  height: 10.0,
                                  decoration: BoxDecoration(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .primaryContainer,
                                      shape: BoxShape.circle),
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
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
