part of 'dark_mode_bloc.dart';

// ignore: must_be_immutable
class DarkModeState extends Equatable {
  DarkModeState({required this.isDarkMode});

  bool isDarkMode;

  @override
  List<Object> get props => [isDarkMode];
}

// ignore: must_be_immutable
class DarkModeInitial extends DarkModeState {
  DarkModeInitial({required super.isDarkMode});
}
