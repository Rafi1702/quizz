import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'score_state.dart';

class ScoreCubit extends Cubit<ScoreState> {
  ScoreCubit() : super(ScoreState());
}
