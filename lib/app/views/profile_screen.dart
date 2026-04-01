import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/app/controllers/theme_controller.dart';
import 'package:task_manager_app/common/utils/glass_card.dart';
import 'package:task_manager_app/common/utils/text_widget.dart';
import 'package:task_manager_app/theme/theme_extension.dart';
import '../controllers/user_controller.dart';
import '../controllers/task_controller.dart';
class ProfilePage extends StatelessWidget {
  final UserController _userController = Get.find();
  final TaskController _taskController = Get.find();
  final controller=Get.put(ThemeController());


@override
Widget build(BuildContext context) {
  final themeColors = Theme.of(context).extension<AppThemeExtension>()!;
  final textTheme = Theme.of(context).textTheme;
   

  return Scaffold(
    body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            themeColors.containerGradientStart,
            themeColors.containerGradientEnd,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                /// 🔹 Top Bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextWidget(
                      text: "Profile",
                      textType: TextType.displayMedium,
                    ),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(Icons.arrow_back, color: textTheme.bodyMedium?.color),
                    )
                  ],
                ),
            
                SizedBox(height: 20),
            
                /// 🔹 Profile Avatar Card
                Center(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: themeColors.cardColor,
                    ),
                    child: Icon(Icons.person, size: 60, color: Colors.white),
                  ),
                ),
            
                SizedBox(height: 20),
            
                /// 🔹 User Info Card
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: themeColors.cardColor,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: "Email",
                        textType: TextType.titleMedium,
                      ),
                      SizedBox(height: 5),
                      Text(
                        _userController.currentUser.value?.email ?? '',
                        style: textTheme.bodyMedium,
                      ),
                      SizedBox(height: 10),
                      TextWidget(
                        text: "Member Since",
                        textType: TextType.titleMedium,
                      ),
                      SizedBox(height: 5),
                      Text(
                        _userController.currentUser.value?.createdAt ?? '',
                        style: textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
            
                SizedBox(height: 20),
            
                /// 🔹 Theme Switch Card
                Obx(() {
  bool isDark = controller.isDarkMode.value;

  return glassCard(
    themeColors: themeColors,
    child: GestureDetector(
      onTap: () => controller.setTHeme(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextWidget(text: 'Switch Theme'),
          AnimatedContainer(
            duration: Duration(milliseconds: 400),
            width: 60,
            height: 30,
            padding: EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: isDark ? Colors.greenAccent : Colors.grey.shade400,
            ),
            child: AnimatedAlign(
              duration: Duration(milliseconds: 400),
              alignment: isDark ? Alignment.centerRight : Alignment.centerLeft,
              child: Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}),
                // Container(
                //   padding: EdgeInsets.all(16),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(20),
                //     color: themeColors.cardColor,
                //   ),
                //   child: Obx(() => Row(
                //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //         children: [
                //           TextWidget(
                //             text: "Dark Mode",
                //             textType: TextType.titleMedium,
                //           ),
                //           Switch(
                //             value: controller.isDarkMode.value,
                //             onChanged: (value) {
                //               controller.setTHeme();
                //             },
                //           )
                //         ],
                //       )),
                // ),
            
                SizedBox(height: 20),
            
                /// 🔹 Task Stats Card
               glassCard(
  themeColors: themeColors,
  child: Obx(() {
    int total = _taskController.tasks.length;
    int completed = _taskController.tasks.where((t) => t.isCompleted).length;
    int pending = total - completed;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextWidget(
          text: "Task Statistics",
          textType: TextType.titleLarge,
        ),
        SizedBox(height: 10),

        _buildAnimatedStatRow("Total Tasks", total, textTheme),
        _buildAnimatedStatRow("Completed", completed, textTheme),
        _buildAnimatedStatRow("Pending", pending, textTheme),
      ],
    );
  }),
),
            
               SizedBox(height: 30,),
            
                /// 🔹 Logout Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      _taskController.logOut();
                      Get.offAllNamed('/login');
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(
                      "Logout",
                      style: textTheme.titleMedium?.copyWith(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
  
}
Widget animatedCount(int value, TextTheme textTheme) {
  return TweenAnimationBuilder<int>(
    tween: IntTween(begin: 0, end: value),
    duration: Duration(milliseconds: 800),
    builder: (context, val, child) {
      return Text(
        "$val",
        style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
      );
    },
  );
}
Widget _buildAnimatedStatRow(String title, int value, TextTheme textTheme) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: textTheme.bodyMedium),
        animatedCount(value, textTheme),
      ],
    ),
  );
}
}