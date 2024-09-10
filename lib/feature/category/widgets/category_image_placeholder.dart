import 'package:flutter/material.dart';
import 'package:quizz/feature/category/cubit/category_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz/feature/questions/presentation/questions_screen.dart';

import '../../questions/cubit/questions_cubit.dart';

class CategoryImagePlaceholder extends StatelessWidget {
  final CategoryUIModels category;
  final List<String> difficulties;

  const CategoryImagePlaceholder(
      {required this.difficulties, required this.category, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const TextSpan(text: ' quiz ?'),
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(QuestionsScreen.route);
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
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              'https://placehold.co/400x250/jpg',
            ),
          ),
          Positioned.fill(
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, bottom: 8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                              child: Chip(
                                elevation: 0,
                                label: Text(
                                  e,
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(
                                          color: e == category.difficulty
                                              ? Colors.white
                                              : Colors.black),
                                ),
                                backgroundColor: e == category.difficulty
                                    ? e.getChipColor()
                                    : Colors.white,
                                side: BorderSide(
                                    color: e.getChipColor(), width: 1.5),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0)),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                    Text(
                      category.category,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                            color: Colors.black,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

extension on String {
  Color getChipColor() {
    switch (this) {
      case 'Easy':
        return Colors.green;
      case 'Medium':
        return Colors.yellowAccent;
      case 'Hard':
        return Colors.red;
      default:
        return Colors.transparent;
    }
  }
}
