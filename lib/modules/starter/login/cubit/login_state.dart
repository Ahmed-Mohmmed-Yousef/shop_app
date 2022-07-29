import 'package:flutter/material.dart';
import 'package:shop_app/models/login_model.dart';

// part of 'login_cubit.dart';

@immutable
abstract class LoginState {}

class LoginInitialState extends LoginState {}

class LoginSaveTokenState extends LoginState {}

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
