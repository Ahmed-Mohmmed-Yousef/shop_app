import 'package:dio/dio.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/end_points.dart';

class CategoryRemoteHelper {

  static Future<Response> getCategories() async {
    return await DioHelper.getData(
      url: CategoryEndPoint.categories,
    );
  } 

}