import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz/presentation/category/cubit/category_cubit.dart';

import 'package:quizz/presentation/category/widgets/category_card.dart';
import 'package:quizz/presentation/global_widgets/cubit/app_cubit.dart';
import 'package:quizz/core/extension.dart';

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
    return BlocListener<AppCubit, AppState>(
      listenWhen: (previous, current) => previous.duration != current.duration,
      listener: (context, state) {
        if (state.duration < 0) {
          context.read<AppCubit>().cancelTimer();
        }
      },
      child: BlocProvider(
        create: (context) => CategoryCubit()..initial(),
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Categories'),
          ),
          body: SafeArea(
            child: SizedBox(
              child: Column(
                children: [
                  BlocBuilder<CategoryCubit, CategoryState>(
                    buildWhen: (prev, curr) => prev.quizzes != curr.quizzes,
                    builder: (context, state) {
                      return ListView.separated(
                        shrinkWrap: true,
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
                  BlocBuilder<AppCubit, AppState>(
                    buildWhen: (previous, current) =>
                        previous.duration != current.duration,
                    builder: (context, state) {
                      return SizedBox(
                          child: Text(state.duration.getHourlyFormat));
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
