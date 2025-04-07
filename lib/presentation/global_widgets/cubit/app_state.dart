part of 'app_cubit.dart';

class AppState extends Equatable {
  final int duration;
  const AppState({this.duration = 0});

  AppState copyWith({int? duration}) {
    return AppState(duration: duration ?? this.duration);
  }

  @override
  List<Object> get props => [duration];
}
