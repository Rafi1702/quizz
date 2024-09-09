import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit()
      : super(
          const CategoryState(),
        );

  void initial() {
    const categories = [
      CategoryUIModels(category: 'Linux', difficulty: 'Easy'),
      CategoryUIModels(category: 'Docker', difficulty: 'Easy'),
      CategoryUIModels(category: 'Cloud', difficulty: 'Easy')
    ];

    const difficulties = ['Easy', 'Medium', 'Hard'];
    return emit(
      const CategoryState(categories: categories, difficulties: difficulties),
    );
  }

  void changeCategoryDifficulty(String category, String difficulty){
    final updatedCategories = state.categories.map((e) {
      if(e.category == category){
        return e.copyWith(difficulty: difficulty);
      }
      return e;
    }).toList();

    emit(state.copyWith(categories: updatedCategories));

  }
}
