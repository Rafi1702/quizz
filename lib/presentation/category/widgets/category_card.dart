import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz/presentation/category/cubit/category_cubit.dart';
import 'package:quizz/presentation/category/model/category_ui.dart';

import 'package:quizz/presentation/category/presentation/category_screen.dart';
import 'package:quizz/presentation/questions/presentation/questions_screen.dart';

class CategoryCard extends StatelessWidget {
  final QuizUIModels quiz;
  final List<String> difficulties;

  const CategoryCard(
      {super.key, required this.quiz, required this.difficulties});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => Navigator.of(context).pushNamed(
          QuestionsScreen.route,
          arguments: QuestionScreenArgument(
              difficulty: quiz.difficulty, category: quiz.category),
        ),
        title: Text(quiz.category),
        subtitle: Wrap(
          spacing: 4.0,
          children: difficulties
              .map(
                (e) => e != "Easy"
                    ? InkWell(
                        onTap: () {},
                        child: const Chip(
                          label: Icon(Icons.lock),
                        ),
                      )
                    : ChoiceChip(
                        onSelected: (_) => context
                            .read<CategoryCubit>()
                            .changeCategoryDifficulty(quiz.category, e),
                        selected: e == quiz.difficulty,
                        labelPadding:
                            const EdgeInsets.symmetric(horizontal: 4.0),
                        elevation: 0,
                        label: Text(e,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith()),
                      ),
              )
              .toList(),
        ),
      ),
    );
  }
}
