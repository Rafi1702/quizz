import 'package:flutter/material.dart';
import 'package:quizz/data/repository/quiz_repository.dart';
import 'package:quizz/domain/model/quiz.dart';

import 'package:quizz/presentation/category/presentation/category_screen.dart';
import 'package:quizz/presentation/global_widgets/cubit/app_cubit.dart';
import 'package:quizz/presentation/global_widgets/error_placeholder.dart';
import 'package:quizz/presentation/questions/barrel.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
      child: MultiBlocListener(
        listeners: [
          // BlocListener<QuestionsCubit, QuestionsState>(
          //   listenWhen: (prev, curr) => prev.isTimesUp != curr.isTimesUp,
          //   listener: (context, state) {
          //     if (state.isTimesUp) {
          //       Navigator.of(context).pop();
          //     }
          //   },
          // ),
          BlocListener<AppCubit, AppState>(
            listenWhen: (previous, current) =>
                previous.duration != current.duration,
            listener: (context, state) {
              if (state.duration == 0) {
                context.read<AppCubit>().cancelTimer();
                Navigator.of(context).pop();
              }
            },
          ),
          BlocListener<QuestionsCubit, QuestionsState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == QuestionsStatus.success) {
                context.read<AppCubit>().startTimer();
              }
            },
          ),
        ],
        child: Scaffold(
          appBar: AppBar(
            leading: BlocSelector<QuestionsCubit, QuestionsState, List<Quiz?>>(
              selector: (state) {
                return state.quiz;
              },
              builder: (context, state) {
                return BackButton(
                  onPressed: () {
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
                        },
                      );
                    }
                  },
                );
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
                    return ErrorPlaceholder(
                      errorMessage: state.errorMessage,
                      onRefreshPressed: () => context
                          .read<QuestionsCubit>()
                          .getQuestions(
                              category: arguments.category,
                              difficulty: arguments.difficulty),
                    );
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
