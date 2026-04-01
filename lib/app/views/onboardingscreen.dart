import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:task_manager_app/app/services/pref_services.dart';
import 'package:task_manager_app/app/views/auth/loginScreen.dart';
import 'package:task_manager_app/common/constant/app_colors.dart';
import 'package:task_manager_app/common/constant/app_images.dart';
import 'package:task_manager_app/common/utils/custom_button.dart';
import 'package:task_manager_app/common/utils/text_widget.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  final ThemeService pref = ThemeService();
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Simple fade-in animation for texts/images
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1200));
    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _completeOnboarding() async {
    await pref.setOnBoardingSeen(true);
    Get.offAll(() => const Loginscreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // from your theme
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  children: [
                    TextWidget(
                      text: 'Welcome to Task Manager',
                      textType: TextType.headlineLarge,
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.h),
                    TextWidget(
                      text: 'Organize your tasks efficiently',
                      textType: TextType.headlineSmall,
                      textAlign: TextAlign.center,
                      color: AppColors.greyColor,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.h),
              FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  height: 250.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    image: DecorationImage(
                      image: AssetImage(AppImages.taskonboarding),
                      fit: BoxFit.cover,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 12,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 60.h),
              CustomButton(
                containerColor: AppColors.primaryTeal,
                text: 'Get Started',
                onTap: _completeOnboarding,
                width: double.infinity,
                height: 55.h,
                borderRadius: 12.r,
              ),
              SizedBox(height: 20.h),
              TextButton(
                onPressed: _completeOnboarding,
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: AppColors.greyColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}