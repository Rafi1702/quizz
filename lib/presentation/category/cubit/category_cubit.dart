import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quizz/presentation/category/model/category_ui.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit()
      : super(
          const CategoryState(),
        );

  void initial() {
    const quizzes = [
      QuizUIModels(category: 'Linux', difficulty: 'Easy', imagePath: ''),
      QuizUIModels(category: 'Docker', difficulty: 'Easy', imagePath: ''),
      QuizUIModels(category: 'Cloud', difficulty: 'Easy', imagePath: '')
    ];

    return emit(
      const CategoryState(quizzes: quizzes),
    );
  }

  void changeCategoryDifficulty(String category, String difficulty) {
    final updatedCategories = state.quizzes.map((e) {
      if (e.category == category) {
        return e.copyWith(difficulty: difficulty);
      }
      return e;
    }).toList();

    emit(state.copyWith(quizzes: updatedCategories));
  }
}
