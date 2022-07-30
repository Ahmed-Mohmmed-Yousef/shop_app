import 'package:dio/dio.dart';
import 'package:shop_app/shared/network/local/cach_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/end_points.dart';

class FavoriteRemoteHelper {

  static Future<Response> getFavorites() async {
    return await DioHelper.getData(
      url: FavoriteEndPoint.getFavorites,
      token: CachHelper.getToken()
    );
  }

  static Future<Response> setFavorites(int productID) async {
    return await DioHelper.postData(
      url: FavoriteEndPoint.getFavorites,
      authorization: CachHelper.getToken(),
      data: {
        'product_id' : productID,
      },
    );
  }
}
