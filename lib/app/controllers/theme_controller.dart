import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/app/services/pref_services.dart';

class ThemeController extends GetxController{ 
  RxBool isDarkMode=false.obs;
  final ThemeService prefservice=ThemeService();
   
   @override
  void onInit() {
    loadtheme();
    // TODO: implement onInit
    super.onInit();
  } 
  void loadtheme()async{ 
     isDarkMode.value=await prefservice.isDarkMode();

  } 
  void setTHeme()async{ 
    isDarkMode.value=!isDarkMode.value;
    await prefservice.setDark(isDarkMode.value);
    Get.changeThemeMode(isDarkMode.value?ThemeMode.dark:ThemeMode.light);
  }
  }