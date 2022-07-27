import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/shared/network/remote/user_remote_helper.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitialState());

  static LoginCubit get(BuildContext context) => BlocProvider.of(context);

  bool _isSecure = false;
  bool get isSecure => _isSecure;
  set isSecure(bool isSecure) {
    _isSecure = isSecure;
    emit(LoginIsSecureChangedState());
  }

  void login(String email, String password) {
    emit(LoginLoadingState());
    UserRemoteHelper.login(email, password).then((value) {
      print(value.data);
      emit(LoginSuccessState());
    }).catchError((onError) {
      print(onError.toString());
      emit(LoginErrorState(onError.toString()));
    });
  }
  
}
