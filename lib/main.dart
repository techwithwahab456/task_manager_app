import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:task_manager_app/app/controllers/task_controller.dart';
import 'package:task_manager_app/app/controllers/user_controller.dart';
import 'package:task_manager_app/app/services/notifucation_service.dart';
import 'package:task_manager_app/app/services/pref_services.dart';
import 'package:task_manager_app/app/views/auth/loginScreen.dart';
import 'package:task_manager_app/app/views/auth/signup_screen.dart';
import 'package:task_manager_app/app/views/homepage.dart';
import 'package:task_manager_app/app/views/onboardingscreen.dart';
import 'package:task_manager_app/theme/app_themes.dart';
import 'app/controllers/theme_controller.dart';
import 'dart:io';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // 1. Initialize FFI for desktop
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  
  // 2. Initialize SharedPreferences FIRST
   final themeService = ThemeService();
  ; // Make sure this completes
  
  // 3. Initialize notifications and AWAIT them
//   await NotificationService.init();
//   int? userId = await themeService.getUserId();
  
//   // 4. Initialize GetX controllers in correct order
//  Get.put(ThemeController());
//   if (userId != null) {
//     Get.put(UserController(initialUserId: userId));
//   } else {
//     Get.put(UserController());
//   }
//   Get.put(TaskController());
 final results = await Future.wait([
    themeService.getUserId(),
    themeService.getOnBoardingSeen(),
    NotificationService.init(),
  ]);

  final int? userId = results[0] as int?;
  final bool onboardingSeen = results[1] as bool? ?? false;

  Get.put(ThemeController());
  Get.put(UserController(initialUserId: userId));
  Get.put(TaskController());
  
  runApp(MyApp(userId: userId, onboardingSeen: onboardingSeen));
}
class MyApp extends StatelessWidget {
   final int? userId;
  final bool onboardingSeen;
   const MyApp({required this.userId, required this.onboardingSeen});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Obx(
          () => GetMaterialApp(
            title: 'Task Manager',
            theme: AppThemes.lightTheme,
            darkTheme: AppThemes.darkTheme,
            themeMode: Get.find<ThemeController>().isDarkMode.value
                ? ThemeMode.dark
                : ThemeMode.light,
            initialRoute: '/',
            getPages: [
              GetPage(name: '/', page: () => OnboardingScreen()),
              GetPage(name: '/onboarding', page: () => OnboardingScreen()),
              GetPage(name: '/login', page: () => Loginscreen()),
              GetPage(name: '/signup', page: () => SignupScreen()),
              GetPage(name: '/home', page: () => Homepage()),
            ],
            debugShowCheckedModeBanner: false,
          ),
        );
      },
    );
  }
    Widget _getInitialPage() {
    // No FutureBuilder, no duplicate Get.put — everything already resolved in main()
    if (!onboardingSeen) {
      return OnboardingScreen();
    } else if (userId != null) {
      return Homepage();
    } else {
      return Loginscreen();
    }
  }

  // Widget _getInitialPage() {
   
    
  //   // Use the already-initialized instances
  //   return FutureBuilder<bool>(
  //     future: pref.getOnBoardingSeen(),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting) {
  //         return Scaffold(
  //           body: Center(child: CircularProgressIndicator()),
  //         );
  //       }
        
  //       if (snapshot.hasError) {
  //         return Scaffold(
  //           body: Center(child: Text('Error loading app')),
  //         );
  //       }
        
  //       bool onboardingSeen = snapshot.data ?? false;
  //       bool isLoggedIn = userController.isLoggedIn.value;
        
  //       if (!onboardingSeen) {
  //         return Onboardingscreen();
  //       } else if (snapshot.data!=null) {
  //         return Homepage();
  //       } else {
  //         return Loginscreen();
  //       }
  //     },
  //   );
  // }
}