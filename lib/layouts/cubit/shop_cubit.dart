import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/models/category_data_model.dart';
import 'package:shop_app/models/favorite_home_product_response.dart';
import 'package:shop_app/models/home_data_model.dart';
import 'package:shop_app/modules/Products/Products_screen.dart';
import 'package:shop_app/modules/categories/categories_screen.dart';
import 'package:shop_app/modules/favorites/favorite_screen.dart';
import 'package:shop_app/modules/settings/settings_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/remote/category_remote.dart';
import 'package:shop_app/shared/network/remote/favorite_remote_helper.dart';
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

  Map<int, bool> favorites = {};

  void changeBottom(int index) {
    _currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  HomeDataResponseModel? responseModel;
  CategoriesResponseModel? getCategoriesResponseModel;
  ChangeFavoriateResponseModel? changeFavoriateResponseModel;

  void getHomeData() {
    emit(ShopLoadingState());
    HomeRemoteHelper.getHomeData().then((value) {
      responseModel = HomeDataResponseModel.fromMap(value.data);
      if (responseModel!.status) {
        responseModel?.data?.products.forEach((element) {
          favorites.addAll({
            element.id: element.inFavorites,
          });
        });
        emit(ShopSuccessState());
        getCategories();
      } else {
        emit(ShopErrorState(responseModel?.message ?? "Undefined error"));
      }
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorState(error));
    });
  }

  void getCategories() {
    emit(ShopLoadingState());
    CategoryRemoteHelper.getCategories().then((value) {
      this.getCategoriesResponseModel =
          CategoriesResponseModel.fromMap(value.data);
      if (getCategoriesResponseModel!.status) {
        print('getCategoriesResponseModel success');
        emit(ShopSuccessState());
      } else {
        emit(ShopErrorState(
            getCategoriesResponseModel?.message ?? "Undefined error"));
      }
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorState(error));
    });
  }

  void changeFavorite(int productID) {
    favorites[productID] = !favorites[productID]!;
    emit(ShopChangeFavoriteState());
    FavoriteRemoteHelper.setFavorites(productID).then((value) {
      changeFavoriateResponseModel =
          ChangeFavoriateResponseModel.fromMap(value.data);
      if(changeFavoriateResponseModel!.status == false) {
        favorites[productID] = !favorites[productID]!;
      }
      emit(ShopSuccessChangeFavoriteState(changeFavoriateResponseModel!));
    }).catchError((onError) {
      favorites[productID] = !favorites[productID]!;
      showToast(text: onError.toString(), status: ToastStatus.ERROR);
      emit(ShopErrorChangeFavoriteState(onError.toString()));
    });
  }

  void changeFavoriteFromFavScreen(int productID) {
    favorites[productID] = !favorites[productID]!;
    emit(ShopChangeFavoriteState());
  }
}
