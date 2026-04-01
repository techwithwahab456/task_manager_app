import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/app/controllers/task_controller.dart';
import 'package:task_manager_app/app/services/notifucation_service.dart';
import 'package:task_manager_app/app/views/addtask_page.dart';
import 'package:task_manager_app/app/views/profile_screen.dart';
import 'package:task_manager_app/app/views/settingpage.dart';
import 'package:task_manager_app/common/constant/app_colors.dart';
import 'package:task_manager_app/common/utils/custom_textfield.dart';
import 'package:task_manager_app/common/utils/glowing_Fab_button.dart';
import 'package:task_manager_app/common/utils/text_widget.dart';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/app/controllers/task_controller.dart';
import 'package:task_manager_app/app/views/addtask_page.dart';
import 'package:task_manager_app/app/views/profile_screen.dart';
import 'package:task_manager_app/app/views/settingpage.dart';
import 'package:task_manager_app/common/constant/app_colors.dart';
import 'package:task_manager_app/common/utils/text_widget.dart';
import 'package:task_manager_app/theme/theme_extension.dart';
class Homepage extends StatefulWidget {
  Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TaskController controller = Get.put(TaskController());

  final TextEditingController searchcontroller = TextEditingController();
  @override
void initState() {
  super.initState();
  // Ask permission when homepage opens
  Future.delayed(Duration.zero, () {
    Get.find<TaskController>().checkNotificationPermission();
  });
}

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
          child: Obx(
            () => Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextWidget(text: 'Good Morning', textType: TextType.displayMedium),
                      
                      IconButton(
                        onPressed: () => Get.to(()=>ProfilePage()),//NotificationService.showInstantNotification(),
                        icon: _buildGlowingIcon(Icons.person, Colors.grey, Colors.blue),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Obx(() => Text(controller.pendingMessage, style: textTheme.bodyMedium)),
                  SizedBox(height: 10),
                  Obx(() => LinearProgressIndicator(
                        value: controller.completionPercent,
                        minHeight: 8,
                        backgroundColor: Colors.white.withOpacity(0.1),
                        valueColor: AlwaysStoppedAnimation(Colors.greenAccent),
                      )),
                  SizedBox(height: 5),
                  Obx(() => Text(
                        "${(controller.completionPercent * 100).toStringAsFixed(0)}% Completed",
                        style: textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                      )),
                  SizedBox(height: 20),
                  Obx(
                    () => AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                  //    padding: EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: themeColors.cardColor,
                      ),
                      child: TextField(
                        onChanged: (value) => controller.searchText.value = value,
                        style: TextStyle(color: textTheme.bodyMedium?.color),
                        decoration: InputDecoration(
                          hintText: "Search tasks...",
                          hintStyle: TextStyle(color: textTheme.bodyMedium?.color?.withOpacity(0.5)),
                          border: InputBorder.none,
                          prefixIcon: Icon(Icons.search, color: textTheme.bodyMedium?.color),
                          suffixIcon: controller.searchText.value.isNotEmpty
                              ? IconButton(
                                  icon: Icon(Icons.close, color: textTheme.bodyMedium?.color),
                                  onPressed: () => controller.searchText.value = '',
                                )
                              : null,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  buildFilterChips(themeColors),
                  Expanded(
                    child: ListView.builder(
                      itemCount: controller.filteredTasks.length,
                      itemBuilder: (context, index) {
                        final task = controller.filteredTasks[index];
                        return TweenAnimationBuilder(
                          duration: Duration(milliseconds: 300 + (index * 100)),
                          tween: Tween(begin: 0.0, end: 1.0),
                          builder: (context, double value, child) {
                            return Opacity(
                              opacity: value,
                              child: Transform.translate(
                                offset: Offset(0, 50 * (1 - value)),
                                child: child,
                              ),
                            );
                          },
                          child: GestureDetector(
                            onLongPress: () => Get.to(() => AddtaskPage(task: task)),
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 10),
                              padding: EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: themeColors.cardColor,
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: BackdropFilter(
                                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            TextWidget(
                                              text: task.title,
                                              textType: TextType.titleLarge,
                                            ),
                                            SizedBox(height: 5),
                                            TextWidget(
                                              text: '${task.description}-${task.deadline}',
                                              textType: TextType.bodyMedium,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        children: [
                                          GestureDetector( 
                                            onTap: () {
                                              controller.deleteTask(task.id!);
                                            },
                                            child: _buildGlowingIcon(Icons.delete, Colors.red, Colors.red[100])),
                                          Container(
                                            width: 10,
                                            height: 10,
                                            decoration: BoxDecoration(
                                              color: task.priority == "High"
                                                  ? Colors.redAccent
                                                  : task.priority == "Medium"
                                                      ? Colors.orangeAccent
                                                      : Colors.greenAccent,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                          Checkbox(
                                            value: task.isCompleted,
                                            onChanged: (value) => controller.toggleCompletion(task),
                                            checkColor: Colors.white,
                                            fillColor: MaterialStateProperty.all(Colors.greenAccent),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      floatingActionButton: GlowingFAB(
        icon: Icons.add,
        glowColor: Colors.blue,
        iconColor: Colors.white,
        onTap: () => Get.to(() => AddtaskPage()),
      ),
    );
  }

  Widget buildFilterChips(AppThemeExtension themeColors) {
    final filters = ["all", "completed", "pending"];
    final labels = ["All", "Completed", "Pending"];

    return Obx(() => Row(
          children: List.generate(filters.length, (index) {
            final value = filters[index];
            final label = labels[index];
            final isSelected = controller.filterType.value == value;

            return Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: GestureDetector(
                onTap: () {
                  controller.filterType.value=value;
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: isSelected ? themeColors.filterChipSelected : themeColors.filterChipUnselected,
                  ),
                  child: Text(
                    label,
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.white70,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            );
          }),
        ));
  }

  Widget _buildGlowingIcon(IconData icon, Color color, Color? iconColor) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.8, end: 1.2),
      duration: const Duration(seconds: 2),
      builder: (context, value, child) {
        return Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.12),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(color: color.withOpacity(0.3 * value), blurRadius: 15 * value, spreadRadius: 1 * value),
            ],
          ),
          child: Icon(icon, color: iconColor, size: 20),
        );
      },
    );
  }
}

// class Homepage extends StatelessWidget {
//   Homepage({super.key});
//   final TaskController controller = Get.put(TaskController());
//   final TextEditingController searchcontroller=TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
   
     
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//             colors: [
//               Color(0xff1e1e2f),
//               Color(0xff2c2c54),
//             ],
//             begin: Alignment.topLeft,
//             end: Alignment.bottomRight,
//           ),
//         ),
//         child: SafeArea(
//           child: Obx(
//             () => Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row( 
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [ 
//                     TextWidget(text: 'Good Morning',
//                     textType: TextType.displayMedium,),
//                      IconButton(
//               onPressed: () {
//                 Get.to(() => ProfilePage());
//               },
//               icon: _buildGlowingIcon(Icons.person, Colors.grey,
//               Colors.blue
//               )),
                   
//                   ],),
//                 Obx(() => Text(
//   controller.pendingMessage,
//   style: TextStyle(color: Colors.white, fontSize: 16),
// )),
// SizedBox(height: 10,),
//                   Obx(() => LinearProgressIndicator(
//   value: controller.completionPercent,
//   minHeight: 8,
//   backgroundColor: Colors.white.withOpacity(0.1),
//   valueColor: AlwaysStoppedAnimation(Colors.greenAccent),
// )),
// SizedBox(height: 5),
// Obx(() => Text(
//   "${(controller.completionPercent * 100).toStringAsFixed(0)}% Completed",
//   style: TextStyle(color: Colors.white70, fontWeight: FontWeight.bold),
// )),
//                   SizedBox(height: 20),
//                Obx(() => AnimatedContainer(
//   duration: Duration(milliseconds: 300),
//   padding: EdgeInsets.symmetric(horizontal: 12),
//   decoration: BoxDecoration(
//     borderRadius: BorderRadius.circular(15),
//     color: Colors.white.withOpacity(0.1),
//   ),
//   child: TextField(
//     onChanged: (value) {
//       controller.searchText.value = value;
//     },
//     style: TextStyle(color: Colors.white),
//     decoration: InputDecoration(
//       hintText: "Search tasks...",
//       hintStyle: TextStyle(color: Colors.white54),
//       border: InputBorder.none,
//       prefixIcon: Icon(Icons.search, color: Colors.white),
//       suffixIcon: controller.searchText.value.isNotEmpty
//           ? IconButton(
//               icon: Icon(Icons.close, color: Colors.white),
//               onPressed: () {
//                 controller.searchText.value = '';
//               },
//             )
//           : null,
//     ),
//   ),
// )),
//                SizedBox(height: 15),

//   buildFilterChips(),
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: controller.filteredTasks.length,
//                       itemBuilder: (context, index) {
//                         final task = controller.filteredTasks[index];

//                         return TweenAnimationBuilder(
//                           duration:
//                               Duration(milliseconds: 300 + (index * 100)),
//                           tween: Tween(begin: 0.0, end: 1.0),
//                           builder: (context, double value, child) {
//                             return Opacity(
//                               opacity: value,
//                               child: Transform.translate(
//                                 offset: Offset(0, 50 * (1 - value)),
//                                 child: child,
//                               ),
//                             );
//                           },
//                           child: GestureDetector(
//                             onTap: () {
//                               Get.to(() => AddtaskPage(task: task));
//                             },
//                             child: Container(
//                               margin: EdgeInsets.symmetric(vertical: 10),
//                               padding: EdgeInsets.all(16),
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(20),
//                                 color: Colors.white.withOpacity(0.1),
//                               ),
//                               child: ClipRRect(
//                                 borderRadius: BorderRadius.circular(20),
//                                 child: BackdropFilter(
//                                   filter:
//                                       ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//                                   child: Row(
//                                     children: [
//                                       Expanded(
//                                         child: Column(
//                                           crossAxisAlignment:
//                                               CrossAxisAlignment.start,
//                                           children: [
//                                             TextWidget(
//                                               text: task.title,
//                                               textType: TextType.titleLarge,
//                                             ),
//                                             SizedBox(height: 5),
//                                             TextWidget(
//                                               text: task.description,
//                                               textType: TextType.bodyMedium,
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       Column(
//                                         children: [
//                                         _buildGlowingIcon(Icons.delete, Colors.red,Colors.red[100]),
//                                         Container(
//   width: 10,
//   height: 10,
//   decoration: BoxDecoration(
//     color: task.priority == "High"
//         ? Colors.redAccent
//         : task.priority == "Medium"
//             ? Colors.orangeAccent
//             : Colors.greenAccent,
//     shape: BoxShape.circle,
//   ),
// ),
//                                           Checkbox(
//                                             checkColor:Colors.white ,
//                                             focusColor: Colors.amber,
//                                             side: BorderSide(color: Colors.white),
//                                             overlayColor:  MaterialStateProperty.resolveWith<Color>((states) {
//     if (states.contains(MaterialState.selected)) {
//       return Colors.greenAccent; // color when checked
//     }
//     return Colors.yellow.withOpacity(0.2); // color when unchecked
//   }),
//                                               fillColor: MaterialStateProperty.resolveWith<Color>((states) {
//     if (states.contains(MaterialState.selected)) {
//       return Colors.greenAccent; // color when checked
//     }
//     return Colors.white.withOpacity(0.2); // color when unchecked
//   }),
//                                             value: task.isCompleted,
//                                             activeColor: Colors.greenAccent,
//                                             onChanged: (value) {
//                                               controller
//                                                   .toggleCompletion(task);
//                                             },
//                                           ),
//                                         ],
//                                       ),
//                                     ],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       floatingActionButton: 
//       GlowingFAB(icon: Icons.add, glowColor:AppColors.btnPrimaryColor , iconColor: Colors.blue, onTap: () {
//          Get.to(() => AddtaskPage());
//       },)
//       // GestureDetector(
//     //     onTap: () {
//     //       Get.to(() => AddtaskPage());
//     //     },
//     //     child: TweenAnimationBuilder(
//     //       tween: Tween(begin: 0.8, end: 1.2),
//     // duration: const Duration(seconds: 2),
//     // builder: (context, value, child) {
      
    

//     //       return ClipRRect(
//     //         borderRadius: BorderRadius.circular(10),
//     //         child: BackdropFilter(
//     //           filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
//     //           child: Container(
//     //             padding: EdgeInsets.all(18),
//     //             decoration: BoxDecoration(
//     //               shape: BoxShape.circle,
//     //               color: Colors.white.withOpacity(0.1),
//     //               boxShadow: [
//     //                 BoxShadow(
//     //                   color: Colors.black,
//     //                   blurRadius: 10,
//     //                   spreadRadius: 2,
//     //                 ),
//     //               ],
//     //             ),
//     //             child: Icon(Icons.add, color: Colors.white, size: 30),
//     //           ),
//     //         ),
//     //       );}
//     //     ),
//     //   ),
//     );
//   }
  
// Widget _buildGlowingIcon(IconData icon, Color color,Color? iconColor) {
//   return TweenAnimationBuilder<double>(
//     tween: Tween(begin: 0.8, end: 1.2),
//     duration: const Duration(seconds: 2),
//     builder: (context, value, child) {
//       return Container(
//         padding: EdgeInsets.all(10.w),
//         decoration: BoxDecoration(
//           color: color.withOpacity(0.12),
//           shape: BoxShape.circle,
//           boxShadow: [
//             // The "Pulse" - shadow size changes based on animation value
//             BoxShadow(
//               color: color.withOpacity(0.3 * value), 
//               blurRadius: 15 * value,
//               spreadRadius: 1 * value,
//             ),
//           ],
          
//           // border: Border.all(
//           //   color: color.withOpacity(0.4),
//           //   width: 1.5,
//           // ),
//         ),
//         child: Icon(icon, color: iconColor, size: 20.sp),
//       );
//     },
//     onEnd: () {}, // Optional: can restart or loop depending on Flutter version
//   );
// }
//   // ------------------ Filter Chips ------------------
//   Widget buildFilterChips() {
//     final filters = ["all", "completed", "pending"];
//     final labels = ["All", "Completed", "Pending"];

//     return Obx(() => Row(
//           children: List.generate(filters.length, (index) {
//             final value = filters[index];
//             final label = labels[index];
//             final isSelected = controller.filterType.value == value;

//             return Padding(
//               padding: const EdgeInsets.only(right: 8.0),
//               child: GestureDetector(
//                 onTap: () => controller.filterType.value = value,
//                 child: AnimatedContainer(
//                   duration: Duration(milliseconds: 300),
//                   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(20),
//                     color: isSelected
//                         ? Colors.greenAccent.withOpacity(0.3)
//                         : Colors.white.withOpacity(0.1),
//                   ),
//                   child: Text(
//                     label,
//                     style: TextStyle(
//                         color: isSelected ? Colors.greenAccent : Colors.white,
//                         fontWeight: FontWeight.bold),
//                   ),
//                 ),
//               ),
//             );
//           }),
//         ));
//   }


// }