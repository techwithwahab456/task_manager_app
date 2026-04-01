
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager_app/common/constant/app_textstyle.dart';
class TextWidget extends StatelessWidget {
  final String text;
  final TextType? textType;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final TextAlign? textAlign;
  final int? maxLines;

  const TextWidget({
    super.key,
    required this.text,
    this.textType,
    this.color,
    this.fontSize,
    this.fontWeight,
    this.textAlign,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    final TextStyle baseStyle = _getBaseStyle(context);

    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.poppins(
        color: color ?? baseStyle.color,
        fontSize: fontSize ?? baseStyle.fontSize,
        fontWeight: fontWeight ?? baseStyle.fontWeight,
        letterSpacing: baseStyle.letterSpacing,
      ),
    );
  }
TextStyle _getBaseStyle(BuildContext context) {
  switch (textType) {
    case TextType.displayLarge: return AppTextStyles.displayLarge(context);
    case TextType.displayMedium: return AppTextStyles.displayMedium(context);
    case TextType.displaySmall: return AppTextStyles.displaySmall(context);
    case TextType.headlineLarge: return AppTextStyles.headlineLarge(context);
    case TextType.headlineMedium: return AppTextStyles.headlineMedium(context);
    case TextType.headlineSmall: return AppTextStyles.headlineSmall(context);
    case TextType.titleLarge: return AppTextStyles.titleLarge(context);
    case TextType.titleMedium: return AppTextStyles.titleMedium(context);
    case TextType.titleSmall: return AppTextStyles.titleSmall(context);
    case TextType.bodyLarge: return AppTextStyles.bodyLarge(context);
    case TextType.bodyMedium: return AppTextStyles.bodyMedium(context);
    case TextType.bodySmall: return AppTextStyles.bodySmall(context);
    case TextType.labelLarge: return AppTextStyles.labelLarge(context);
    case TextType.labelMedium: return AppTextStyles.labelMedium(context);
    case TextType.labelSmall: return AppTextStyles.labelSmall(context);
    default: return AppTextStyles.bodyMedium(context);
  }
}
}

enum TextType {
  displayLarge, displayMedium, displaySmall,
  headlineLarge, headlineMedium, headlineSmall,
  titleLarge, titleMedium, titleSmall,
  bodyLarge, bodyMedium, bodySmall,
  labelLarge, labelMedium, labelSmall,
}