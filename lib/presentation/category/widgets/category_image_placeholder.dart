import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:quizz/feature/category/cubit/category_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz/feature/category/model/category_ui.dart';

import 'package:quizz/feature/category/presentation/category_screen.dart';
import 'package:quizz/feature/questions/presentation/questions_screen.dart';

class CategoryImagePlaceholder extends StatelessWidget {
  final QuizUIModels category;
  final List<String> difficulties;

  const CategoryImagePlaceholder(
      {required this.difficulties, required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Image.network(
            'https://placehold.co/400x250',
            errorBuilder: (context, _, stackTrace) {
              log("",stackTrace: stackTrace);
              return Container(
                color: Colors.amber,
                height: 250,
                width: 400,
                child: const Center(child: Text('Error')),
              );
            },
          ),
        ),
        Positioned.fill(
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 12.0,
                vertical: 4.0,
              ),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onSurface,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8.0),
                  bottomRight: Radius.circular(8.0),
                ),
              ),
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        category.category,
                        style: Theme.of(context).textTheme.titleLarge!.copyWith(
                              color: Theme.of(context).colorScheme.onInverseSurface,
                              fontWeight: FontWeight.w900,
                            ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          showDialog<void>(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                  content: Text.rich(
                                    TextSpan(
                                      text: 'Do u really want to start ',
                                      children: [
                                        TextSpan(
                                          text: category.category,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        const TextSpan(text: ' quiz ?'),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context)
                                            .pushReplacementNamed(
                                          QuestionsScreen.route,
                                          arguments: QuestionScreenArgument(
                                              category: category.category,
                                              difficulty: category.difficulty),
                                        );
                                      },
                                      child: const Text('Yes'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('No'),
                                    ),
                                  ]);
                            },
                          );
                        },
                        child: const Text('Start'),
                      )
                    ],
                  ),
                  Wrap(
                    spacing: 4.0,
                    children: difficulties
                        .map(
                          (e) => GestureDetector(
                            onTap: () {
                              context
                                  .read<CategoryCubit>()
                                  .changeCategoryDifficulty(
                                      category.category, e);
                            },

                            child: ChoiceChip(
                              color: WidgetStatePropertyAll(Theme.of(context).colorScheme.onSecondary),
                              selected: e == category.difficulty,
                              labelPadding:
                                  const EdgeInsets.symmetric(horizontal: 4.0),
                              elevation: 0,
                              label: Text(e,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(

                                      )),
                            ),
                          ),
                        )
                        .toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

extension on String {
  Color getChipColor() {
    switch (this) {
      case 'Easy':
        return Colors.green;
      case 'Medium':
        return Colors.amber;
      case 'Hard':
        return Colors.red;
      default:
        return Colors.transparent;
    }
  }
}
