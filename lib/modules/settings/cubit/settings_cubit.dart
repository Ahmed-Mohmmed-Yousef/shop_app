import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/models/user_data_model.dart';
import 'package:shop_app/shared/network/remote/user_remote_helper.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  static UserDataModel? usermodel;

  SettingsCubit() : super(SettingsInitial());

  static SettingsCubit get(BuildContext context) => BlocProvider.of(context);

  void getUserData() {
    if (SettingsCubit.usermodel != null) {
      emit(SettingsShowData(SettingsCubit.usermodel!));
    } else {
      print("GOOOOOOO");
      UserRemoteHelper.getProfile().then((value) {
        GetProfileResponseModel response = GetProfileResponseModel.fromMap(value.data);
        if (response.status) {
          SettingsCubit.usermodel = response.userData;
          emit(SettingsShowData(SettingsCubit.usermodel!));
        } else {
          emit(SettingsError(response.message ?? "Error"));
        }
      }).catchError((onError) {
        emit(SettingsError(onError.toString()));
      });
    }
  }
}
