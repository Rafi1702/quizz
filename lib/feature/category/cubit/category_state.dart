part of 'category_cubit.dart';

class CategoryUIModels {
  const CategoryUIModels({required this.category, required this.difficulty});

  final String category;
  final String difficulty;

  CategoryUIModels copyWith({String? category, String? difficulty}) =>
      CategoryUIModels(
          category: category ?? this.category,
          difficulty: difficulty ?? this.difficulty);
}

class CategoryState extends Equatable {
  const CategoryState({
    this.categories = const [],
    this.difficulties = const [],
  });

  final List<CategoryUIModels> categories;
  final List<String> difficulties;

  CategoryState copyWith(
          {List<CategoryUIModels>? categories, List<String>? difficulties}) =>
      CategoryState(
          categories: categories ?? this.categories,
          difficulties: difficulties ?? this.difficulties);

  @override
  // TODO: implement props
  List<Object?> get props => [categories, difficulties];
}
