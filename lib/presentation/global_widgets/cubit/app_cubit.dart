import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(const AppState());

  Timer? timer;

  void startTimer() async {
    timer?.cancel();

    emit(state.copyWith(duration: 60));

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (timer.tick == 0) timer.cancel();

      return emit(
        state.copyWith(duration: state.duration - 1),
      );
    });
  }

  void cancelTimer() {
    timer?.cancel();
    return emit(
      state.copyWith(duration: 0),
    );
  }
}
