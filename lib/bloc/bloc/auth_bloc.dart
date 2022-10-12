import 'package:equatable/equatable.dart';
import 'package:todo_app_with_firebase/data/repositories/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'auth_event.dart';
import 'auth_state.dart';

// part 'auth_event.dart';
// part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(UnAuthenticated()) {
    on<SignInRequested>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.signIn(
            email: event.email, password: event.password);
        emit((Authenticated()));
      } catch (e) {
        // review in error
        emit(AuthError(error: e.toString()));
        emit(UnAuthenticated());
      }
    });
    on<GoogleSignInRequested>((event, emit) async {
      emit(Loading());
      try {
        await authRepository.signInWithGoogle();
        emit(Authenticated());
      } catch (e) {
        emit(AuthError(error: e.toString()));
        emit(UnAuthenticated());
      }
    });

    on<SignOutRequested>((event, emit) async {
      emit(Loading());
      await authRepository.signOut();
    });
  }
}
