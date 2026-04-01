
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager_app/common/constant/app_colors.dart';
import 'package:task_manager_app/common/utils/custom_container.dart';
import 'package:task_manager_app/common/utils/text_widget.dart';

class CategoryPieCard extends StatelessWidget {
  final List<Widget> legendItems;

  const CategoryPieCard({super.key, required this.legendItems});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      elevation: 2,
      padding: EdgeInsets.all(20.w),
      child: Column(
        children: [
          TextWidget(text: "Spending Breakdown", textType: TextType.headlineMedium),
          SizedBox(height: 20.h),
          SizedBox(
            height: 200.h,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Here you would place your Circular Chart Widget
                CircularProgressIndicator(value: 0.7, strokeWidth: 20, color: AppColors.primaryTeal),
                TextWidget(text: "Total\n75k", textAlign: TextAlign.center, textType: TextType.bodyMedium),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Wrap(children: legendItems),
        ],
      ),
    );
  }
}