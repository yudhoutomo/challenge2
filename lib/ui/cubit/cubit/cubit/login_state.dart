part of 'login_cubit.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {}

class LoginInitialState extends LoginState {
  final Status status;
  final Login? data;

  const LoginInitialState({
    required this.status,
    this.data,
  });
  @override
  List<Object?> get props => [status, data];
}

class UserLoginState extends LoginState {}
