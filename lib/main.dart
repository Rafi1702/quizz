import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz/core/network_client.dart';
import 'package:quizz/data/datasources/quiz_remote.dart';
import 'package:quizz/data/repository/quiz_repository.dart';

import 'package:quizz/presentation/category/presentation/category_screen.dart';

import 'package:quizz/presentation/questions/presentation/questions_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:quizz/theme/theme.dart';

import 'presentation/score/presentation/score_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");

  final httpClient = MyClient();

  runApp(
    RepositoryProvider(
      create: (context) => QuizRepository(
        QuizApi(httpClient),
      ),
      child: const MyApp(),
    ),
  );
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
        colorScheme: MaterialTheme.darkMediumContrastScheme(),
        useMaterial3: true,
      ),
      routes: {
        CategoryScreen.route: (context) => const CategoryScreen(),
        QuestionsScreen.route: (context) => const QuestionsScreen(),
        ScoreScreen.route: (context) => const ScoreScreen(),
      },
    );
  }
}
