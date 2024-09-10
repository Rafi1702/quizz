import 'dart:async';

import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quizz/domain/entity/quiz.dart';
import 'package:quizz/domain/repository/quiz_repository.dart';

part 'questions_state.dart';

class QuestionsCubit extends Cubit<QuestionsState> {
  QuestionsCubit({required this.quizRepository})
      : super(const QuestionsState()) {
    getQuestions();
  }

  late Timer timer;
  final QuizRepository quizRepository;

  @override
  Future<void> close() async {
    timer.cancel();
    super.close();
  }

  Future<void> getQuestions() async {
    try {
      final quiz = await quizRepository.getQuiz();

      emit(state.copyWith(
          status: QuestionsStatus.success,
          question: quiz[state.currentIndex],
          quiz: quiz));

      // Start Timer After Success to fetch Quiz
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        onDurationChange(state.duration - 1);
      });
    } catch (e) {
      emit(state.copyWith(status: QuestionsStatus.error));
    }
  }

  void onDurationChange(int value) {
    final bool isTimesUp = value == 0;
    if (isTimesUp) timer.cancel();
    return emit(state.copyWith(duration: value, isTimesUp: isTimesUp));
    // print('seconds: ${state.seconds}, condition: ${state.isTimesUp}');
  }

  void onAnswerSelected(int index) {
    final updatedChoice =
        state.question?.answers?.answers?.asMap().entries.map((e) {
      if (e.key == index) {
        return e.value.copyWith(isSelected: true);
      }
      return e.value.copyWith(isSelected: false);
    }).toList();

    final updateQuestion = state.question?.copyWith(
      answers: state.question?.answers?.copyWith(answers: updatedChoice),
    );

    final updatedQuiz = state.quiz.asMap().entries.map((e) {
      if (e.key == state.currentIndex) {
        return updateQuestion;
      }
      return e.value;
    }).toList();

    return emit(
      state.copyWith(
        quiz: updatedQuiz,
        question: updateQuestion,
      ),
    );
  }

  void onQuestionsNext() {
    if (state.currentIndex == state.quiz.length - 1) return;

    final currentIndex = state.currentIndex + 1;
    final updatedQuestion = state.quiz[currentIndex];

    emit(state.copyWith(question: updatedQuestion, currentIndex: currentIndex));
  }
}
