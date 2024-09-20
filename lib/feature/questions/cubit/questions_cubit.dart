import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import 'package:quizz/domain/repository/quiz_repository.dart';
import 'package:quizz/domain/model/quiz.dart';
part 'questions_state.dart';

class QuestionsCubit extends Cubit<QuestionsState> {
  QuestionsCubit({required this.quizRepository})
      : super(const QuestionsState());

  Timer? timer;
  final QuizRepository quizRepository;
  int mustBeAnsweredForSubmit = 0;

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

      final updatedAnswerPerQuestionQuiz = quiz.map((e) {
        e = e.copyWith(
          shouldBeAnswerPerQuestion:
          countAnswerPerQuestion<CorrectAnswer>(e,
              getItem: (item) => item.correctAnswers,
              select: (select) => select.isCorrect),
        );
        return e;
      }).toList();

      mustBeAnsweredForSubmit = countTotalAnswer<CorrectAnswer>(
        quiz,
        getItems: (item) => item.correctAnswers,
        select: (select) => select.isCorrect,
      );

      final question = updatedAnswerPerQuestionQuiz[state.currentIndex];

      emit(state.copyWith(
        status: QuestionsStatus.success,
        question: question,
        quiz: updatedAnswerPerQuestionQuiz,
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
    List<Answer>? updatedAnswer = updatedAnswers(
      question: state.question,
      choicedIndex: index,
    );

    final updatedChoice = state.question?.copyWith(
      answers: updatedAnswer,
    );

    final updatedTotalAnsweredByUserPerQuestion = updatedChoice?.copyWith(
      totalAnsweredByUserPerQuestion: countAnswerPerQuestion<Answer>(
          updatedChoice,
          getItem: (item) => item.answers,
          select: (select) => select.isSelected),
    );

    final updatedQuiz = state.quiz
        .asMap()
        .entries
        .map((e) {
      if (e.key == state.currentIndex) {
        return updatedTotalAnsweredByUserPerQuestion?.copyWith(
            isAnswered: e.value!.shouldBeAnswerPerQuestion ==
                e.value!.shouldBeAnswerPerQuestion);
      }
      return e.value;
    }).toList();

    var isAllAnswered = countTotalAnswer<Answer>(updatedQuiz,
        getItems: (item) => item.answers,
        select: (select) => select.isSelected) ==
        mustBeAnsweredForSubmit;

    return emit(
      state.copyWith(
        quiz: updatedQuiz,
        question: updatedTotalAnsweredByUserPerQuestion,
        isAllAnswered: isAllAnswered,
      ),
    );
  }

  void onQuestionNextOrPrevious(int Function(int) changeIndex) {
    if (state.currentIndex == state.quiz.length - 1 && state.currentIndex < 0) {
      return;
    }

    final currentIndex = changeIndex(state.currentIndex);

    final updatedQuestion = state.quiz[currentIndex];


    return emit(
      state.copyWith(
        question: updatedQuestion,
        currentIndex: currentIndex,

      ),
    );
  }

  //helper
  int countTotalAnswer<T>(List<Quiz?> quiz, {
    required List<T> Function(Quiz) getItems,
    required bool Function(T) select,
  }) {
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

  int countAnswerPerQuestion<T>(Quiz? question, {
    required List<T> Function(Quiz) getItem,
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

  List<Answer>? updatedAnswers({
    required Quiz? question,
    required int choicedIndex,
  }) {
    if (question == null) return question?.answers;

    final answers = question.answers;
    if (question.multipleCorrectAnswer) {
      var choicesMultiple = answers
          .asMap()
          .entries
          .where((e) => e.value.isSelected)
          .map((e) => e.key)
          .toList();

      return answers
          .asMap()
          .entries
          .map((e) {
        if (choicesMultiple.length == question.shouldBeAnswerPerQuestion &&
            !choicesMultiple.contains(e.key)) {
          return e.value;
        }
        if (e.key == choicedIndex) {
          return e.value.copyWith(isSelected: !e.value.isSelected);
        }

        return e.value;
      }).toList();
    }
    return answers
        .asMap()
        .entries
        .map((e) {
      if (e.key == choicedIndex) {
        return e.value.copyWith(isSelected: true);
      }
      return e.value.copyWith(isSelected: false);
    }).toList();
  }
}
