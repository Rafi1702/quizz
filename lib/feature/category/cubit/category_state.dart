part of 'category_cubit.dart';

class CategoryUIModels {
  const CategoryUIModels({required this.category, required this.difficulty});

  final String category;
  final String difficulty;
}

class CategoryState extends Equatable {
  const CategoryState({
    this.categories = const [],
    this.difficulties = const [],
  });

  final List<CategoryUIModels> categories;
  final List<String> difficulties;

  @override
  // TODO: implement props
  List<Object?> get props => [categories, difficulties];
}
