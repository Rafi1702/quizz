import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz/domain/repository/quiz_repository.dart';
import 'package:quizz/feature/category/presentation/category_screen.dart';
import 'package:quizz/feature/questions/cubit/questions_cubit.dart';
import 'package:quizz/feature/questions/widgets/change_question_button.dart';
import 'package:quizz/feature/questions/widgets/question_extra.dart';
import 'package:quizz/feature/questions/widgets/question_section.dart';

class QuestionsScreen extends StatelessWidget {
  static const route = '/questions';

  const QuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final arguments =
        ModalRoute.of(context)!.settings.arguments as QuestionScreenArgument;

    return BlocProvider(
      create: (context) =>
          QuestionsCubit(quizRepository: context.read<QuizRepository>())
            ..getQuestions(
                category: arguments.category, difficulty: arguments.difficulty),
      child: Scaffold(
        appBar: AppBar(
          leading: BackButton(onPressed: () {
            showDialog<void>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Caution'),
                    content:
                        const Text('Your answer is not saved when you quit'),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).popUntil(ModalRoute.withName(CategoryScreen.route));
                          },
                          child: const Text('Yes')),
                      ElevatedButton(onPressed: () {}, child: const Text('No'))
                    ],
                  );
                });
          }),
          title: Text(arguments.category),
          centerTitle: true,
        ),
        body: SafeArea(
          child: BlocBuilder<QuestionsCubit, QuestionsState>(
            buildWhen: (prev, curr) => prev.status != curr.status,
            builder: (context, state) {
              switch (state.status) {
                case QuestionsStatus.initial:
                  return const Center(child: CircularProgressIndicator());
                case QuestionsStatus.success:
                  return const Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 10.0,
                    ),
                    child: Column(
                      children: [
                        QuestionExtra(),
                        SizedBox(height: 20.0),
                        QuestionSection(),
                        Spacer(),
                        ChangeQuestionButton(),
                      ],
                    ),
                  );
                default:
                  return Container();
              }
            },
          ),
        ),
      ),
    );
  }
}







