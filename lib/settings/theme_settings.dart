import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class ThemeSettings{
  final _getStorage=GetStorage();
  final storageKey="isDarkMode";

  ThemeMode getThemeMode(){
    return isSaveDarkMode()?ThemeMode.dark:ThemeMode.light;
  }

  bool isSaveDarkMode(){
    print('TEMAS'+_getStorage.read(storageKey).toString());
    return _getStorage.read(storageKey)??false;
    
  }

  void saveThemeMode(bool isDarkMode){
    _getStorage.write(storageKey, isDarkMode);
  }

  Future <void> changeThemeMode(bool isDarkMode)async{
    Get.changeThemeMode(isSaveDarkMode()?ThemeMode.light:ThemeMode.dark);
    saveThemeMode(isDarkMode);
  }
}