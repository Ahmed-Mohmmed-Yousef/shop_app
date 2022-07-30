import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layouts/cubit/shop_cubit.dart';
import 'package:shop_app/models/favorite_home_product_response.dart';
import 'package:shop_app/shared/network/local/cach_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/end_points.dart';
import 'package:shop_app/shared/network/remote/favorite_remote_helper.dart';

part 'favorit_state.dart';

class FavoritCubit extends Cubit<FavoritState> {
  FavoritCubit() : super(FavoritInitialState());

  static FavoritCubit get(BuildContext context) => BlocProvider.of(context);
  late List<FavoriteProduct> myFavorite;

  void getFavorites() {
    emit(FavoritLoadingState());
    FavoriteRemoteHelper.getFavorites().then((value) {
      GetFavoriteResponseModel responseModel =
          GetFavoriteResponseModel.fromMap(value.data);
      if (responseModel.status) {
        myFavorite = responseModel.data?.favorites ?? [];
        if (myFavorite.isEmpty) {
          emit(FavoritEmptyState());
        } else {
          emit(FavoritSuccessState());
        }
      } else {
        emit(FavoritErrorState(responseModel.message ?? 'Unknown Error'));
      }
    }).catchError((onError) {
      print(onError.toString());
      emit(FavoritErrorState(onError.toString()));
    });
  }

  void deleteFromFav(ShopCubit cubit, int productID) {
    emit(FavoritLoadingState());
    FavoriteRemoteHelper.setFavorites(productID)
        .then((value) {
          var responseModel = ChangeFavoriateResponseModel.fromMap(value.data);
          if(responseModel.status) {
            getFavorites();
            cubit.changeFavoriteFromFavScreen(productID);
          } else {
            emit(FavoritErrorState(responseModel.message));
          }
        })
        .catchError((onError) {
          emit(FavoritErrorState(onError.toString()));
        });
  }
}
