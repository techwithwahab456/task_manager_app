import 'package:flutter/material.dart';

Widget buildCustomTextField({
  required BuildContext context,
  required TextEditingController controller,
  required String label,
  required IconData icon,
  bool isPassword = false,
  bool? visibility, // just the value, no Obx inside
  String? Function(String?)? validator,
  void Function(String)? onChange,
  IconData? suffixIcon,
  VoidCallback? onPressedSuffixIcon,
}) {
  return TextFormField(
    controller: controller,
    obscureText: isPassword && !(visibility ?? false),
    onChanged: onChange,
    style: Theme.of(context).textTheme.bodyMedium,
    validator: validator,
    decoration: InputDecoration(
      labelText: label,
      labelStyle: Theme.of(context).inputDecorationTheme.labelStyle,
      prefixIcon: Icon(icon, color: Theme.of(context).inputDecorationTheme.prefixIconColor),
      suffixIcon: isPassword
          ? IconButton(
              icon: Icon(visibility == true ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey),
              onPressed: onPressedSuffixIcon,
            )
          : (suffixIcon != null
              ? IconButton(icon: Icon(suffixIcon), onPressed: onPressedSuffixIcon)
              : null),
      enabledBorder: Theme.of(context).inputDecorationTheme.enabledBorder,
      focusedBorder: Theme.of(context).inputDecorationTheme.focusedBorder,
      filled: true,
      fillColor: Theme.of(context).inputDecorationTheme.fillColor,
    ),
  );
}