import 'package:equatable/equatable.dart';
part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class SignInRequested extends AuthEvent {
  SignInRequested({required this.email, required this.password});
  final String email;
  final String password;
}

class SignUpRequested extends AuthEvent {
  SignUpRequested({required this.email, required this.password});
  final String email;
  final String password;
}

class GoogleSignInRequested extends AuthEvent {}

class SignOutRequested extends AuthEvent {}