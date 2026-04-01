import 'package:flutter/material.dart';

@immutable
class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  final Color containerGradientStart;
  final Color containerGradientEnd;
  final Color filterChipSelected;
  final Color filterChipUnselected;
  final Color cardColor;

  const AppThemeExtension({
    required this.containerGradientStart,
    required this.containerGradientEnd,
    required this.filterChipSelected,
    required this.filterChipUnselected,
    required this.cardColor,
  });

  @override
  AppThemeExtension copyWith({
    Color? containerGradientStart,
    Color? containerGradientEnd,
    Color? filterChipSelected,
    Color? filterChipUnselected,
    Color? cardColor,
  }) {
    return AppThemeExtension(
      containerGradientStart: containerGradientStart ?? this.containerGradientStart,
      containerGradientEnd: containerGradientEnd ?? this.containerGradientEnd,
      filterChipSelected: filterChipSelected ?? this.filterChipSelected,
      filterChipUnselected: filterChipUnselected ?? this.filterChipUnselected,
      cardColor: cardColor ?? this.cardColor,
    );
  }

  @override
  AppThemeExtension lerp(ThemeExtension<AppThemeExtension>? other, double t) {
    if (other is! AppThemeExtension) return this;
    return AppThemeExtension(
      containerGradientStart: Color.lerp(containerGradientStart, other.containerGradientStart, t)!,
      containerGradientEnd: Color.lerp(containerGradientEnd, other.containerGradientEnd, t)!,
      filterChipSelected: Color.lerp(filterChipSelected, other.filterChipSelected, t)!,
      filterChipUnselected: Color.lerp(filterChipUnselected, other.filterChipUnselected, t)!,
      cardColor: Color.lerp(cardColor, other.cardColor, t)!,
    );
  }
}