// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dark_mode_event.dart';
part 'dark_mode_state.dart';

class DarkModeBloc extends Bloc<DarkModeEvent, DarkModeState> {
  DarkModeBloc() : super(DarkModeInitial(isDarkMode: false)) {
    on<DarkModeOnEvent>((event, emit) {
      emit(
        DarkModeInitial(isDarkMode: true),
      );
    });

    on<DarkModeOffEvent>((event, emit) {
      emit(
        DarkModeInitial(isDarkMode: false),
      );
    });
  }
}
