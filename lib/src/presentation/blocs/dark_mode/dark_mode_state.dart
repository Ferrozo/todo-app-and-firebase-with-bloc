part of 'dark_mode_bloc.dart';

abstract class DarkModeState extends Equatable {
  const DarkModeState();
  
  @override
  List<Object> get props => [];
}

class DarkModeInitial extends DarkModeState {}
