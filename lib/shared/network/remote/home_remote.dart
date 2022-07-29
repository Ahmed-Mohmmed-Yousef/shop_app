import 'package:dio/dio.dart';
import 'package:shop_app/shared/network/local/cach_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/end_points.dart';

class HomeRemoteHelper {

  static Future<Response> getHomeData() async {
    return await DioHelper.getData(
      url: HomeEndPoint.home,
      token: CachHelper.getToken(),
    );
  } 
}