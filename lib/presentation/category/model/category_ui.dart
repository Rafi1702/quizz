class QuizUIModels {
  const QuizUIModels(
      {required this.category,
      required this.difficulty,
      required this.imagePath});

  final String category;
  final String difficulty;
  final String imagePath;

  QuizUIModels copyWith(
          {String? category, String? difficulty, String? imagePath}) =>
      QuizUIModels(
        category: category ?? this.category,
        difficulty: difficulty ?? this.difficulty,
        imagePath: imagePath ?? this.imagePath,
      );
}