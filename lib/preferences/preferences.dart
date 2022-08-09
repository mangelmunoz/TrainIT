import 'package:shared_preferences/shared_preferences.dart';

class Preferences {

  static late SharedPreferences _prefs;
  static bool _isDarkMode = false;

  static Future init() async => _prefs = await SharedPreferences.getInstance();
  
  static bool get isDarkMode => _prefs.getBool('isDarkMode') ?? _isDarkMode;
  
  static set isDarkMode(bool isDarkMode){
    _isDarkMode = isDarkMode;
    _prefs.setBool('isDarkMode', isDarkMode);
  }
}