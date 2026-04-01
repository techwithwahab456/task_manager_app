// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyles {
  static TextStyle displayLarge(BuildContext context) => Theme.of(context).textTheme.displayLarge!;
  static TextStyle displayMedium(BuildContext context) => Theme.of(context).textTheme.displayMedium!;
  static TextStyle displaySmall(BuildContext context) => Theme.of(context).textTheme.displaySmall!;

  static TextStyle headlineLarge(BuildContext context) => Theme.of(context).textTheme.headlineLarge!;
  static TextStyle headlineMedium(BuildContext context) => Theme.of(context).textTheme.headlineMedium!;
  static TextStyle headlineSmall(BuildContext context) => Theme.of(context).textTheme.headlineSmall!;

  static TextStyle titleLarge(BuildContext context) => Theme.of(context).textTheme.titleLarge!;
  static TextStyle titleMedium(BuildContext context) => Theme.of(context).textTheme.titleMedium!;
  static TextStyle titleSmall(BuildContext context) => Theme.of(context).textTheme.titleSmall!;

  static TextStyle bodyLarge(BuildContext context) => Theme.of(context).textTheme.bodyLarge!;
  static TextStyle bodyMedium(BuildContext context) => Theme.of(context).textTheme.bodyMedium!;
  static TextStyle bodySmall(BuildContext context) => Theme.of(context).textTheme.bodySmall!;

  static TextStyle labelLarge(BuildContext context) => Theme.of(context).textTheme.labelLarge!;
  static TextStyle labelMedium(BuildContext context) => Theme.of(context).textTheme.labelMedium!;
  static TextStyle labelSmall(BuildContext context) => Theme.of(context).textTheme.labelSmall!;
}

// class AppTextStyles {
//   static TextStyle displayLarge(BuildContext context) => TextStyle(
//         fontSize: 30.sp,
//         fontWeight: FontWeight.w800,
//         color: Theme.of(context).textTheme.bodyText1?.color,
//       );

//   static TextStyle amountLarge(BuildContext context) => TextStyle(
//         fontSize: 28.sp,
//         fontWeight: FontWeight.bold,
//         color: Theme.of(context).primaryColor,
//       );

//   static TextStyle headlineMedium(BuildContext context) => TextStyle(
//         fontSize: 18.sp,
//         fontWeight: FontWeight.w600,
//         color: Theme.of(context).textTheme.bodyText2?.color,
//       );

//   static TextStyle bodyMedium(BuildContext context) => TextStyle(
//         fontSize: 14.sp,
//         fontWeight: FontWeight.normal,
//         color: Theme.of(context).textTheme.bodyText2?.color,
//       );

//   static TextStyle buttonText(BuildContext context) => TextStyle(
//         fontSize: 16.sp,
//         fontWeight: FontWeight.bold,
//         color: Theme.of(context).primaryColor,
//       );
// }