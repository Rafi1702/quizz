part of 'category_cubit.dart';

class CategoryState extends Equatable {
  const CategoryState({this.categories = const []});

  final List<String> categories;

  @override
  // TODO: implement props
  List<Object?> get props => [categories];
}
