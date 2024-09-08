import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz/feature/category/cubit/category_cubit.dart';
import 'package:quizz/feature/category/cubit/category_cubit.dart';
import 'package:quizz/feature/category/widgets/category_image_placeholder.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          child: BlocBuilder<CategoryCubit, CategoryState>(
            buildWhen: (prev, curr) => prev.categories != curr.categories,
            builder: (context, state) {
              return ListView.separated(
                padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                itemCount: state.categories.length,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10.0),
                itemBuilder: (context, index) => CategoryImagePlaceholder(
                  categoryTitle: state.categories[index],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
