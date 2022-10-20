part of 'dark_mode_bloc.dart';

class DarkModeState extends Equatable {
  DarkModeState({required this.isDarkMode});

  bool isDarkMode;

  @override
  List<Object> get props => [isDarkMode];
}

class DarkModeInitial extends DarkModeState {
  DarkModeInitial({required super.isDarkMode});
}
