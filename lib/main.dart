import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz/data/datasources/quiz_remote.dart';
import 'package:quizz/feature/category/cubit/category_cubit.dart';
import 'package:quizz/feature/category/presentation/category_screen.dart';
import 'package:quizz/feature/questions/cubit/questions_cubit.dart';
import 'package:quizz/feature/questions/presentation/questions_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'domain/repository/quiz_repository.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  runApp(RepositoryProvider(
    create: (context) => QuizRepository(QuizApi()),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            )),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      home: BlocProvider<CategoryCubit>(
        create: (context) =>
        CategoryCubit()
          ..initial(),
        child: const CategoryScreen(),
      ),
      routes: {
        QuestionsScreen.route: (context) =>
            BlocProvider(
              create: (context) => QuestionsCubit(quizRepository: context.read<QuizRepository>()),
              child: const QuestionsScreen(),
            ),
      },
    );
  }
}
