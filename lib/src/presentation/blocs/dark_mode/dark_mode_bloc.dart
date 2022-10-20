import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'dark_mode_event.dart';
part 'dark_mode_state.dart';

class DarkModeBloc extends Bloc<DarkModeEvent, DarkModeState> {
  DarkModeBloc() : super(DarkModeInitial()) {
    on<DarkModeEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
