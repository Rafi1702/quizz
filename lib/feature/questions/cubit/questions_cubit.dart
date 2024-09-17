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
  int mustBeAnsweredForSubmit = 0;
  int mustBeAnsweredPerQuestion = 0;
  int correctAnswerPerQuestion = 0;

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

      mustBeAnsweredForSubmit = countTotalAnswer<CorrectAnswersEntity>(
        quiz,
        getItems: (item) => item.correctAnswers!,
        select: (select) => select.isCorrect!,
      );

      final question = quiz[state.currentIndex];

      correctAnswerPerQuestion =
          countAnswerPerQuestion<CorrectAnswersEntity>(question,
              getItem: (item) => item.correctAnswers!,
              select: (select) => select.isCorrect!);

      mustBeAnsweredPerQuestion =
          countAnswerPerQuestion<AnswerEntity>(question,
              getItem: (item) => item.answers!,
              select: (select) => select.isSelected!);

      emit(state.copyWith(
        status: QuestionsStatus.success,
        question: question,
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
    List<AnswerEntity>? updatedChoice =
        updatedAnswers(question: state.question, choicedIndex: index);

    final updateQuestion = state.question?.copyWith(
      answers: updatedChoice,
    );

    final updatedQuiz = state.quiz.asMap().entries.map((e) {
      if (e.key == state.currentIndex) {
        return updateQuestion;
      }
      return e.value;
    }).toList();

    var isAllAnswered = countTotalAnswer<AnswerEntity>(updatedQuiz,
            getItems: (item) => item.answers!,
            select: (select) => select.isSelected!) ==
        mustBeAnsweredForSubmit;

    return emit(
      state.copyWith(
        quiz: updatedQuiz,
        question: updateQuestion,
        isAllAnswered: isAllAnswered,
      ),
    );
  }

  void onQuestionNext() {
    if (state.currentIndex == state.quiz.length - 1) return;

    final currentIndex = state.currentIndex + 1;
    final updatedQuestion = state.quiz[currentIndex];
    correctAnswerPerQuestion =
        countAnswerPerQuestion<CorrectAnswersEntity>(updatedQuestion,
            getItem: (item) => item.correctAnswers!,
            select: (select) => select.isCorrect!);

    mustBeAnsweredPerQuestion = countAnswerPerQuestion<AnswerEntity>(
        updatedQuestion,
        getItem: (item) => item.answers!,
        select: (select) => select.isSelected!);



    return emit(
        state.copyWith(question: updatedQuestion, currentIndex: currentIndex));
  }

  void onQuestionPrevious() {
    if (state.currentIndex == 0) return;

    final currentIndex = state.currentIndex - 1;
    final updatedQuestion = state.quiz[currentIndex];
    correctAnswerPerQuestion =
        countAnswerPerQuestion<CorrectAnswersEntity>(updatedQuestion,
            getItem: (item) => item.correctAnswers!,
            select: (select) => select.isCorrect!);

    mustBeAnsweredPerQuestion = countAnswerPerQuestion<AnswerEntity>(
        updatedQuestion,
        getItem: (item) => item.answers!,
        select: (select) => select.isSelected!);

    print(correctAnswerPerQuestion);
    print(mustBeAnsweredPerQuestion);

    return emit(
        state.copyWith(question: updatedQuestion, currentIndex: currentIndex));
  }

  //helper
  int countTotalAnswer<T>(
    List<QuizEntity?> quiz, {
    required List<T> Function(QuizEntity) getItems,
    required bool Function(T) select,
  }) {
    if (quiz == null) return 0;
    int counter = 0;
    for (var e in quiz) {
      final items = getItems(e!);
      for (var x in items) {
        if (select(x)) {
          counter++;
        }
      }
    }
    return counter;
  }

  int countAnswerPerQuestion<T>(
    QuizEntity? question, {
    required List<T> Function(QuizEntity) getItem,
    required bool Function(T) select,
  }) {
    if (question == null) {
      return 0;
    }
    var counter = 0;

    final item = getItem(question);

    for (var e in item) {
      if (select(e)) {
        counter++;
      }
    }
    return counter;
  }

  List<AnswerEntity>? updatedAnswers(
      {required QuizEntity? question, required int choicedIndex}) {
    if (question == null) return question?.answers;

    if (question.multipleCorrectAnswer!) {
      return question?.answers?.asMap().entries.map((e) {
        if (e.key == choicedIndex) {
          return e.value.copyWith(isSelected: !e.value.isSelected!);
        }
        return e.value;
      }).toList();
    }
    return state.question?.answers?.asMap().entries.map((e) {
      if (e.key == choicedIndex) {
        return e.value.copyWith(isSelected: true);
      }
      return e.value.copyWith(isSelected: false);
    }).toList();
  }
}
