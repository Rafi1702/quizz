import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:quizz/domain/entity/quiz.dart';
import 'package:quizz/domain/repository/quiz_repository.dart';

part 'questions_state.dart';

class QuestionsCubit extends Cubit<QuestionsState> {
  QuestionsCubit({required this.quizRepository})
      : super(const QuestionsState());

  Timer? timer;
  final QuizRepository quizRepository;

  @override
  Future<void> close() async {
    timer?.cancel();
    super.close();
  }

  Future<void> getQuestions(
      {required String category, required String difficulty}) async {
    emit(state.copyWith(status: QuestionsStatus.initial));
    try {
      final quiz = await quizRepository.getQuiz(
          category: category, difficulty: difficulty);

      emit(state.copyWith(
        status: QuestionsStatus.success,
        question: quiz[state.currentIndex],
        quiz: quiz,
        quizLength: quiz.length,
      ));

      // Start Timer After Success to fetch Quiz
      timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        onDurationChange(state.duration - 1);
      });
    } catch (e) {
      emit(state.copyWith(
          status: QuestionsStatus.error, errorMessage: e.toString()));
    }
  }

  void onDurationChange(int value) {
    final bool isTimesUp = value == 0;
    if (isTimesUp) timer?.cancel();
    return emit(state.copyWith(duration: value, isTimesUp: isTimesUp));
  }

  void onAnswerSelected(int index) {
    final updatedChoice = state.question?.answers?.asMap().entries.map((e) {
      if (e.key == index) {
        return e.value?.copyWith(isSelected: true);
      }
      return e.value?.copyWith(isSelected: false);
    }).toList();

    final updateQuestion = state.question?.copyWith(
      answers: updatedChoice,
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

  void onQuestionNext() {
    if (state.currentIndex == state.quiz.length - 1) return;

    final currentIndex = state.currentIndex + 1;
    final updatedQuestion = state.quiz[currentIndex];

    return emit(
        state.copyWith(question: updatedQuestion, currentIndex: currentIndex));
  }

  void onQuestionPrevious() {
    if (state.currentIndex == 0) return;

    final currentIndex = state.currentIndex - 1;
    final updatedQuestion = state.quiz[currentIndex];

    return emit(
        state.copyWith(question: updatedQuestion, currentIndex: currentIndex));
  }
}
