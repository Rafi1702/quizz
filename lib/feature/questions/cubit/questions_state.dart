part of 'questions_cubit.dart';

sealed class QuestionsState extends Equatable {
  const QuestionsState();
}

final class QuestionsInitial extends QuestionsState {
  @override
  List<Object> get props => [];
}
