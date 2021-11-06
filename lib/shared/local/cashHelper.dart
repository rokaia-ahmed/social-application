import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper {


  static late SharedPreferences sharedPreferences;

  static init() async
  {
    sharedPreferences = await SharedPreferences.getInstance();
  }

// ********************
  static Future<bool> putBoolean({
    required String key ,
    required bool value ,
  })async{
    return await sharedPreferences.setBool(key, value);
  }

//************************

  static dynamic getData({
    required dynamic key,
  })
  {
    return sharedPreferences.get(key);
  }

  //*********************
  static dynamic save ;
  static Future<bool> saveData ({
    required String key ,
    required dynamic value ,
  }) async
  {
    if(value is String) return save = await sharedPreferences.setString(key, value);
    if(value is int) return save= await sharedPreferences.setInt(key, value);
    if(value is bool) return save = await sharedPreferences.setBool(key, value);

    return save;
  }
  //************************
  static Future<bool> removeData(
      {required String key})async{
    return await sharedPreferences.remove(key);
  }
}