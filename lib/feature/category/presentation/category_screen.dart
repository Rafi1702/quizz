import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz/feature/category/cubit/category_cubit.dart';

import 'package:quizz/feature/category/widgets/category_card.dart';

class QuestionScreenArgument {
  final String difficulty;
  final String category;

  const QuestionScreenArgument(
      {required this.difficulty, required this.category});
}

class CategoryScreen extends StatelessWidget {
  static const route = '/';

  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryCubit()..initial(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Categories'),
        ),
        body: SafeArea(
          child: SizedBox(
            child: BlocBuilder<CategoryCubit, CategoryState>(
              buildWhen: (prev, curr) => prev.quizzes != curr.quizzes,
              builder: (context, state) {
                return ListView.separated(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 16.0),
                  itemCount: state.quizzes.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 10.0),
                  itemBuilder: (context, index) => CategoryCard(
                    quiz: state.quizzes[index],
                    difficulties: state.difficulties,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
