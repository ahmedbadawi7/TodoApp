import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeServices {
  final GetStorage _storage = GetStorage();
  final _key = 'isDarkMode';

   _saveThemetoStorage(bool isDarkMode){
    _storage.write(_key, isDarkMode);
  }

  bool _loadThemeFromstorage(){
    return _storage.read<bool>(_key) ?? false;
  }

  ThemeMode get theme => _loadThemeFromstorage() ? ThemeMode.dark:ThemeMode.light;

  void switchTheme(){
    Get.changeThemeMode(_loadThemeFromstorage()? ThemeMode.light:ThemeMode.dark);
    _saveThemetoStorage(!_loadThemeFromstorage());
  }

}
