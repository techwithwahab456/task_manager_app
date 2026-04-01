import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager_app/app/controllers/theme_controller.dart';
import 'package:task_manager_app/common/constant/app_colors.dart';
import 'package:task_manager_app/theme/theme_extension.dart';

// class AppThemes {
//   static ThemeData lightTheme = ThemeData(
//     brightness: Brightness.light,
//     primarySwatch: Colors.blue,
//     scaffoldBackgroundColor: AppColors.primaryTeal,
//     appBarTheme: const AppBarTheme(
//       backgroundColor: Colors.blue,
//       foregroundColor: Colors.white,
//     ),
//      extensions: [
//     const AppThemeExtension(
//       containerGradientStart: Color(0xffa0e1e0),
//       containerGradientEnd: Color(0xff50c8c7),
//       filterChipSelected: Colors.greenAccent,
//       filterChipUnselected: Colors.white54,
//       cardColor: Colors.white70,
//     )
//   ],

//     iconTheme: IconThemeData(color: Colors.blue),
 
//     inputDecorationTheme: InputDecorationTheme(
//       filled: true,
//       fillColor: Colors.white.withOpacity(0.1),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(color: Colors.blueAccent),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(color: Colors.blue, width: 2),
//       ),
//       hintStyle: TextStyle(color: Colors.black54),
//       labelStyle: TextStyle(color: Colors.blue),
//       prefixIconColor: Colors.blue,
//     ),
 
//     textTheme: TextTheme(
//       displayLarge: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold, color: AppColors.blackColor,
//       ),
//       displayMedium: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold, color: Colors.black87),
//       displaySmall: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600, color: Colors.black54),
      
//       headlineLarge: TextStyle(fontSize: 22.sp,fontStyle: FontStyle.italic,
//        fontWeight: FontWeight.w700, color: Colors.black),
//       headlineMedium: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600, color: Colors.black87),
//       headlineSmall: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: Colors.black54),

//       titleLarge: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.black),
//       titleMedium: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.black87),
//       titleSmall: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: Colors.black54),

//       bodyLarge: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal, color: Colors.black87),
//       bodyMedium: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.normal, color: Colors.black54),
//       bodySmall: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.normal, color: Colors.black45),
      
//       labelLarge: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.blue),
//       labelMedium: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color: Colors.blueAccent),
//       labelSmall: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400, color: Colors.blueGrey),
//     ),
//   );

//   static ThemeData darkTheme = ThemeData(
//     brightness: Brightness.dark,
//     primarySwatch: Colors.grey,
//     scaffoldBackgroundColor: Colors.grey[900],
//     appBarTheme: AppBarTheme(
//       backgroundColor: Colors.grey[800],
//       foregroundColor: Colors.white,
//     ),
    

//     iconTheme: IconThemeData(color: Colors.tealAccent),
  
//     inputDecorationTheme: InputDecorationTheme(
//       filled: true,
//       fillColor: Colors.grey[800],
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(color: Colors.tealAccent),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(12),
//         borderSide: BorderSide(color: Colors.tealAccent, width: 2),
//       ),
//       hintStyle: TextStyle(color: Colors.white70),
//       labelStyle: TextStyle(color: Colors.tealAccent),
//       prefixIconColor: Colors.tealAccent,
//     ),
//       textTheme: TextTheme(
//       displayLarge: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold, color: Colors.white),
//       displayMedium: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold, color: Colors.white70),
//       displaySmall: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600, color: Colors.white60),
      
//       headlineLarge: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w700, color: Colors.white),
//       headlineMedium: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600, color: Colors.white70),
//       headlineSmall: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: Colors.white60),

//       titleLarge: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.white),
//       titleMedium: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.white70),
//       titleSmall: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: Colors.white60),

//       bodyLarge: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal, color: Colors.white70),
//       bodyMedium: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.normal, color: Colors.white60),
//       bodySmall: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.normal, color: Colors.white54),
      
//       labelLarge: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.tealAccent),
//       labelMedium: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color: Colors.teal),
//       labelSmall: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400, color: Colors.teal[200]),
//     ),
//      extensions: [
//      AppThemeExtension(
//       containerGradientStart: Color(0xff1e1e2f),
//     containerGradientEnd: Color(0xff2c2c54),
//        filterChipSelected: Colors.tealAccent.withOpacity(0.3),
//     filterChipUnselected: Colors.white.withOpacity(0.1),
//       cardColor: Colors.white70,
//     )
//   ],

    
//   );
// }



class AppThemes {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primarySwatch: Colors.blue,
    
    iconTheme: IconThemeData(color: Colors.blue),
 
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white.withOpacity(0.1),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.blueAccent),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.blue, width: 2),
      ),
      hintStyle: TextStyle(color: Colors.black54),
      labelStyle: TextStyle(color: Colors.blue),
      prefixIconColor: Colors.blue,
    ),
    extensions: [
      const AppThemeExtension(
        containerGradientStart: Color(0xffa0e1e0),
        containerGradientEnd: Color(0xff50c8c7),
        filterChipSelected: Colors.greenAccent,
        filterChipUnselected: Colors.white54,
        cardColor: Colors.white70,
      ),
    ],
   
    textTheme: TextTheme(
      displayLarge: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold, color: AppColors.blackColor,
      ),
      displayMedium: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold, color: Colors.black87),
      displaySmall: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600, color: Colors.black54),
      
      headlineLarge: TextStyle(fontSize: 22.sp,fontStyle: FontStyle.italic,
       fontWeight: FontWeight.w700, color: Colors.black),
      headlineMedium: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600, color: Colors.black87),
      headlineSmall: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: Colors.black54),

      titleLarge: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.black),
      titleMedium: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.black87),
      titleSmall: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: Colors.black54),

      bodyLarge: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal, color: Colors.black87),
      bodyMedium: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.normal, color: Colors.black54),
      bodySmall: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.normal, color: Colors.black45),
      
      labelLarge: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.blue),
      labelMedium: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color: Colors.blueAccent),
      labelSmall: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400, color: Colors.blueGrey),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Color(0xff1e1e2f),
    primarySwatch: Colors.teal,
    
    iconTheme: IconThemeData(color: Colors.tealAccent),
  
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[800],
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.tealAccent),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.tealAccent, width: 2),
      ),
      hintStyle: TextStyle(color: Colors.white70),
      labelStyle: TextStyle(color: Colors.tealAccent),
      prefixIconColor: Colors.tealAccent,
    ),
    extensions: [
      const AppThemeExtension(
        containerGradientStart: Color(0xff1e1e2f),
        containerGradientEnd: Color(0xff2c2c54),
        filterChipSelected: Colors.tealAccent,
        filterChipUnselected: Colors.white12,
        cardColor: Color(0xff2c2c54),
      ),
    ],
    textTheme: TextTheme(
      displayLarge: TextStyle(fontSize: 32.sp, fontWeight: FontWeight.bold, color: Colors.white),
      displayMedium: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold, color: Colors.white70),
      displaySmall: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w600, color: Colors.white60),
      
      headlineLarge: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.w700, color: Colors.white),
      headlineMedium: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w600, color: Colors.white70),
      headlineSmall: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: Colors.white60),

      titleLarge: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600, color: Colors.white),
      titleMedium: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.white70),
      titleSmall: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: Colors.white60),

      bodyLarge: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.normal, color: Colors.white70),
      bodyMedium: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.normal, color: Colors.white60),
      bodySmall: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.normal, color: Colors.white54),
      
      labelLarge: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold, color: Colors.tealAccent),
      labelMedium: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w500, color: Colors.teal),
      labelSmall: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400, color: Colors.teal[200]),
    ),
  );
}