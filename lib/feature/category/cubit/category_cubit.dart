import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit()
      : super(
        const CategoryState(),
        );

  void getCategories(){
    return emit(const CategoryState(categories: ['Linux', 'Docker', 'Cloud']));
  }
}
