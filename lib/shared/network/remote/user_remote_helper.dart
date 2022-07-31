import 'package:dio/dio.dart';
import 'package:shop_app/shared/network/local/cach_helper.dart';
import 'package:shop_app/shared/network/remote/dio_helper.dart';
import 'package:shop_app/shared/network/remote/end_points.dart';

class UserRemoteHelper {
  static Future<Response> login(String email, String password) async {
    return await DioHelper.postData(
      url: UserEndPoint.login,
      data: {
        'email': email,
        'password': password,
      },
    );
  }

  static Future<Response> register({required String name, required String email, required String password, required String phone}) async {
    return await DioHelper.postData(
      url: UserEndPoint.register,
      data: {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,
      },
    );
  }

  static Future<Response> logout(String fcmToken) async {
    return await DioHelper.postData(
      url: UserEndPoint.logout,
      data: {
        'fcm_token': fcmToken,
      },
    );
  }

  static Future<Response> getProfile() async {
    return await DioHelper.getData(
      url: UserEndPoint.profile,
      token: CachHelper.getToken(),
    );
  }


}
