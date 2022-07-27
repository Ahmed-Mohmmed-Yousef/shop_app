import 'package:shared_preferences/shared_preferences.dart';

class CachKey {
  static const apiLang = 'api_lang';
  static const isLightMod = 'isLightMod';
  static const isRtl = 'isRtl';
}

class CachHelper {

  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> putBool({required String key, required bool value}) async {
    return await sharedPreferences.setBool(key, value);
  }

  static bool getBool({required String key}) {
    return sharedPreferences.getBool(key) ?? true;
  }

  static Future<bool> putString({required String key, required String value}) async {
    return await sharedPreferences.setString(key, value);
  }

  static String? getString({required String key}) {
    return sharedPreferences.getString(key);
  }
}