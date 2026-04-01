import 'dart:ui';

import 'package:flutter/widgets.dart';
import 'package:task_manager_app/theme/theme_extension.dart';

Widget glassCard({required Widget child, required AppThemeExtension themeColors}) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(20),
    child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: themeColors.cardColor.withOpacity(0.6),
        ),
        child: child,
      ),
    ),
  );
}