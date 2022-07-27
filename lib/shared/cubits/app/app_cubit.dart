import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/shared/network/local/cach_helper.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());

  static AppCubit get(BuildContext context) => BlocProvider.of(context);

  bool get isDarktMod => CachHelper.getBool(key: CachKey.isDarktMod);

  set isLightMode(bool isDarktMod) {
    CachHelper.putBool(key: CachKey.isDarktMod, value: isDarktMod)
        .then((value) => emit(AppThemeChanded()));
  }

  bool get isRtl => CachHelper.getBool(key: CachKey.isRtl);

  set isRtl(bool isRtl) {
    CachHelper.putBool(key: CachKey.isRtl, value: isRtl)
        .then((value) => emit(AppDirectionChanged()));
  }
}
