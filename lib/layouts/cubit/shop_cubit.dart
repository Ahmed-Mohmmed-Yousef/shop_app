import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/models/home_data_model.dart';
import 'package:shop_app/modules/Products/Products_screen.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorite_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/network/local/cach_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/end_points.dart';
import 'package:shop_app/shared/network/remote/home_remote.dart';

part 'shop_state.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());

  static ShopCubit get(BuildContext context) => BlocProvider.of(context);

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;

  List<Widget> screens = const [
    ProductsScreen(),
    CategoriesScreen(),
    FavoriteScreen(),
    SettingsScreen(),
  ];

  void changeBottom(int index) {
    _currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeDataResponseModel? responseModel;

  void getHomeProduct() {
    emit(ShopLoadingState());
    HomeRemoteHelper.getHomeData().then((value) {
      responseModel = HomeDataResponseModel.fromMap(value.data);
      if (responseModel!.status) {
        emit(ShopSuccessState());
      } else {
         emit(ShopErrorState(responseModel?.message ?? "Undefined error"));
      }
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorState(error));
    });
  }
}
