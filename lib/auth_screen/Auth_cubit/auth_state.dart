part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

class RegisterAuthloading extends AuthState {}

class RegisterAuthSucess extends AuthState {}

class RegisterAuthfail extends AuthState {
  final String ErrorMeesage;

  RegisterAuthfail({required this.ErrorMeesage});
}

class loginAuthloading extends AuthState {}

class loginAuthSucess extends AuthState {}

class loginAuthfail extends AuthState {}
