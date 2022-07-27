import 'package:dio/dio.dart';
import 'package:shop_app/shared/network/local/cach_helper.dart';



class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
      baseUrl: 'https://student.valuxapps.com/api/',
      receiveDataWhenStatusError: true,
      headers: {
        'Content-Type': 'application/json',
        'lang': 'ar',
      },
    ));
  }

  static Future<Response> getData({
    required String url,
    required Map<String, dynamic> query,
    String? authorization,
  }) async {
    dio.options.headers = {
        'Authorization' : authorization,
        'lang': CachHelper.getString(key: 'api_lang') ?? 'ar',
      };
    return await dio.get(url, queryParameters: query);
  }

  static Future<Response> postData({
    required String url,
    required dynamic data,
    String? authorization,
    Map<String, dynamic>? query,
  }) async {
    dio.options.headers = {
        'Authorization' : authorization,
        'lang': CachHelper.getString(key: 'api_lang') ?? 'ar',
      };
    return await dio.post(
      url,
      queryParameters: query,
      data: data,
    );
  }
}
