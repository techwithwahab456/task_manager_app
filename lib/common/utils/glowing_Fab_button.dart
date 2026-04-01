import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GlowingFAB extends StatelessWidget {
  final IconData icon;
  final Color glowColor;     // background & glow
  final Color iconColor;     // icon color
  final double size;         // container size
  final double iconSize;     // icon size
  final VoidCallback onTap;  // action
  final ShapeBorder shape;   // circle or rounded rect

  const GlowingFAB({
    super.key,
    required this.icon,
    required this.glowColor,
    required this.iconColor,
    required this.onTap,
    this.size = 60,
    this.iconSize = 30,
    this.shape = const CircleBorder(),
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.8, end: 1.2),
        duration: const Duration(seconds: 2),
        curve: Curves.easeInOut,
        builder: (context, value, child) {
          return Transform.scale(
             scale: 0.9 + 0.1 * (1 + sin(DateTime.now().millisecondsSinceEpoch / 500)),
            child: ClipRRect(
              borderRadius: shape is CircleBorder
                  ? BorderRadius.circular(size / 2)
                  : BorderRadius.circular(15),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  width: size,
                  height: size,
                  decoration: ShapeDecoration(
                    color: glowColor.withOpacity(0.15),
                    shape: shape,
                    shadows: [
                      BoxShadow(
                        color: glowColor.withOpacity(0.3 * value),
                        blurRadius: 15 * value,
                        spreadRadius: 1 * value,
                      ),
                    ],
                  ),
                  child: Icon(icon, color: iconColor, size: iconSize),
                ),
              ),
            ),
          );
        },
        onEnd: () {}, // optional: can loop animation
      ),
    );
  }
}