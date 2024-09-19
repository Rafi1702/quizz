import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:quizz/domain/entity/quiz.dart';
import 'package:quizz/domain/repository/quiz_repository.dart';
import 'package:quizz/feature/category/presentation/category_screen.dart';
import 'package:quizz/feature/questions/cubit/questions_cubit.dart';
import 'package:quizz/feature/questions/widgets/change_question_button.dart';
import 'package:quizz/feature/questions/widgets/number_list.dart';
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
      child: BlocListener<QuestionsCubit, QuestionsState>(
        listenWhen: (prev, curr) => prev.isTimesUp != curr.isTimesUp,
        listener: (context, state) {
          if (state.isTimesUp) {
            Navigator.of(context).pop();
          }
        },
        child: Scaffold(
          appBar: AppBar(
            leading:
                BlocSelector<QuestionsCubit, QuestionsState, List<QuizEntity?>>(
              selector: (state) {
                return state.quiz;
              },
              builder: (context, state) {
                return BackButton(onPressed: () {
                  if (state.isEmpty) {
                    Navigator.of(context).pop();
                  } else {
                    showDialog<void>(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Caution'),
                            content: const Text(
                                'Your answer is not saved when you quit'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.of(context).popUntil(
                                    ModalRoute.withName(CategoryScreen.route)),
                                child: const Text(
                                  'Yes',
                                  style: TextStyle(color: Colors.redAccent),
                                ),
                              ),
                              TextButton(
                                  onPressed: () => Navigator.of(context).pop(),
                                  child: const Text(
                                    'No',
                                  ))
                            ],
                          );
                        });
                  }
                });
              },
            ),
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
                          NumberList(),
                          SizedBox(height: 20.0),
                          QuestionExtra(),
                          SizedBox(height: 20.0),
                          Expanded(
                            child: SingleChildScrollView(
                              child: QuestionSection(),
                            ),
                          ),
                          ChangeQuestionButton(),
                        ],
                      ),
                    );
                  case QuestionsStatus.error:
                    return Center(
                        child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.refresh_rounded,
                          size: 80.0,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              context.read<QuestionsCubit>().getQuestions(
                                  category: arguments.category,
                                  difficulty: arguments.difficulty);
                            },
                            child: Text('Load Data')),
                      ],
                    ));
                  default:
                    return Container();
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
