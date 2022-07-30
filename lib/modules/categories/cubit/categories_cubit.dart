import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:shop_app/models/category_data_model.dart';
import 'package:shop_app/shared/network/remote/category_remote.dart';

part 'categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());

  static CategoriesCubit get(BuildContext context) => BlocProvider.of(context);

  CategoriesResponseModel? model;

  void getCategories() {
    print('model?.status = ${model?.status}');
    if (model == null || model!.status == false) {
      print('Loading cate');
      emit(CategoriesLoadingState());
      CategoryRemoteHelper.getCategories().then((value) {
        print('Done cate');
        model = CategoriesResponseModel.fromMap(value.data);
        print(model?.status);
        emit(CategoriesSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(CategoriesErrorState(error.toString()));
      });
    } else { print('categories is ${model?.data.data.length}'); }
  }
}
