import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/login_model.dart';
import 'package:shop_app/modules/starter/login/cubit/login_state.dart';
import 'package:shop_app/shared/network/local/cach_helper.dart';
import 'package:shop_app/shared/network/remote/user_remote_helper.dart';



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
      LoginModel model = LoginModel.fromMap(value.data);
      emit(LoginSuccessState(model));
    }).catchError((onError) {
      print(onError.toString());
      emit(LoginErrorState(onError.toString()));
    });
  }

  void saveUserToken(String token) {
    CachHelper.putString(key: CachKey.userToken, value: token).then((value) {
      emit(LoginSaveTokenState());
    });
  }
  
}
