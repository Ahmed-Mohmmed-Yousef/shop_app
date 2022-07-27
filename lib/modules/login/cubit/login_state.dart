part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginIsSecureChangedState extends LoginState {}

class LoginLoadingState extends LoginState {}

class LoginSuccessState extends LoginState {
  final LoginModel model;

  LoginSuccessState(this.model);
}

class LoginErrorState extends LoginState {
  final String error;

  LoginErrorState(this.error);
}
