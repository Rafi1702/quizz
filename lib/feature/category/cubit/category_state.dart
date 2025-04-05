part of 'category_cubit.dart';

class CategoryState extends Equatable {
  const CategoryState({
    this.quizzes = const [],
    this.difficulties = const ['Easy', 'Medium', 'Hard'],
  });

  final List<QuizUIModels> quizzes;
  final List<String> difficulties;

  CategoryState copyWith(
          {List<QuizUIModels>? quizzes, List<String>? difficulties}) =>
      CategoryState(
          quizzes: quizzes ?? this.quizzes,
          difficulties: difficulties ?? this.difficulties);

  @override
  // TODO: implement props
  List<Object?> get props => [quizzes, difficulties];
}
