import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/app/controllers/task_controller.dart';
import 'package:task_manager_app/app/controllers/user_controller.dart';
import 'package:task_manager_app/app/models/task_model.dart';
import 'package:task_manager_app/app/services/pref_services.dart';
import 'package:task_manager_app/common/utils/custom_button.dart';
import 'package:task_manager_app/common/utils/custom_textfield.dart';
import 'package:task_manager_app/common/utils/glass_card.dart';
import 'package:task_manager_app/common/utils/text_widget.dart';
import 'package:task_manager_app/theme/theme_extension.dart';

class AddtaskPage extends StatelessWidget {
  final Task? task;
    final TextEditingController titlecontroller=TextEditingController();
   final TextEditingController descriptioncontroller=TextEditingController();
   final RxString priority = "Low".obs; // default priority
   AddtaskPage({super.key,  this.task}){ 
    if (task!=null){ 
      titlecontroller.text=task!.title!;
      descriptioncontroller.text=task!.description!;
          priority.value = task!.priority;
    }
   }
   @override
Widget build(BuildContext context) {
  final TaskController controller = Get.find();
  final UserController usercntl = Get.find();
  final themeColors = Theme.of(context).extension<AppThemeExtension>()!;
  final textTheme = Theme.of(context).textTheme;

  return Scaffold(
    backgroundColor:  themeColors.containerGradientEnd,
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
                      text: task == null ? "Add Task" : "Edit Task",
                      textType: TextType.displayMedium,
                    ),
                    IconButton(
                      onPressed: () => Get.back(),
                      icon: Icon(Icons.arrow_back,
                          color: textTheme.bodyMedium?.color),
                    )
                  ],
                ),

                SizedBox(height: 30),

                /// 🔹 Title Field (Glass)
                glassCard(
                  themeColors: themeColors,
                  child: buildCustomTextField(
                       context: context,
                    controller: titlecontroller,
                    label: 'Task Title',
                    icon: Icons.task,
                   // Inside buildCustomTextField call:
suffixIcon: controller.isListening.value ? Icons.stop : Icons.mic,
// You might need to wrap the buildCustomTextField in an Obx 
// if the icon doesn't change automatically.
                  onPressedSuffixIcon: () async {
  // Check if speech is already initialized/listening
  if (!controller.speech.isListening) {
    bool available = await controller.speech.initialize(
      onError: (val) => print('STT Error: $val'),
      onStatus: (val) => print('STT Status: $val'),
    );

    if (available) {
      controller.isListening.value = true;
      controller.speech.listen(
        onResult: (result) {
          // result.finalResult ensures we only set the text once it's certain
          titlecontroller.text = result.recognizedWords;
          if (result.finalResult) {
            controller.isListening.value = false;
          }
        },
      );
    } else {
      Get.snackbar("Error", "Speech recognition not available on this device");
    }
  } else {
    controller.isListening.value = false;
    controller.speech.stop();
  }
},
                  ),
                ),

                SizedBox(height: 20),

                /// 🔹 Description Field (Glass)
                glassCard(
                  themeColors: themeColors,
                  child: buildCustomTextField(
                       context: context,
                    controller: descriptioncontroller,
                    label: 'Description',
                    icon: Icons.description,
                  ),
                ),

                SizedBox(height: 20),

                /// 🔹 Priority Selector (Premium Chips)
                glassCard(
                  themeColors: themeColors,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextWidget(
                        text: "Priority",
                        textType: TextType.titleMedium,
                      ),
                      SizedBox(height: 20),

                      Obx(() => Row(
                            children: ["High", "Medium", "Low"].map((p) {
                              bool isSelected = priority.value == p;

                              return GestureDetector(
                                onTap: () => priority.value = p,
                                child:AnimatedContainer(
                                  
  duration: Duration(milliseconds: 400),
  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    color: isSelected
                                        ? (p == "High"
                                            ? Colors.redAccent
                                            : p == "Medium"
                                                ? Colors.orangeAccent
                                                : Colors.greenAccent)
                                        : themeColors.cardColor
                                            .withOpacity(0.4),
    // color: isSelected ? color : themeColors.cardColor,
    boxShadow: isSelected
        ? [
            BoxShadow(
              color: themeColors.cardColor.withOpacity(0.6),
              blurRadius: 12,
              spreadRadius: 2,
            )
          ]
        : [],
  ),
  child: Text(
    p,
    style: TextStyle(color: Colors.white),
  ),
)
                              );
                            }).toList(),
                          )),
                    ],
                  ),
                ),
                  SizedBox(height: 30),
                Obx(() => GestureDetector(
  onTap: () async {
    DateTime? date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (time != null) {
    controller.    selectedDate.value = DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );
      }
    }
  },
  child: glassCard(
    themeColors: themeColors,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
      controller.    selectedDate.value == null
              ? "Select Deadline"
              :controller. selectedDate.value.toString(),
          style: textTheme.bodyMedium,
        ),
        Icon(Icons.calendar_today),
      ],
    ),
  ),
)),

                SizedBox(height: 30),

                /// 🔹 Add / Update Button (Animated)
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.9, end: 1),
                  duration: Duration(milliseconds: 500),
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: child,
                    );
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        final ThemeService pref = ThemeService();
                        final userId = await pref.getUserId();

                        if (userId == null) {
                          Get.snackbar("Error", "User not found");
                          return;
                        }

                        if (titlecontroller.text.isNotEmpty &&
                            descriptioncontroller.text.isNotEmpty) {
                               int notifId = (task?.id ?? DateTime.now().millisecondsSinceEpoch) & 0x7FFFFFFF;
                          final newtask = Task(
                            id: task?.id,
                            title: titlecontroller.text.trim(),
                            description:
                                descriptioncontroller.text.trim(),
                            isCompleted: task?.isCompleted ?? false,
                            createdAt:
                                DateTime.now().toIso8601String(),
                            userId: userId,
                            priority: priority.value,
                            deadline: controller.selectedDate.value,
                          );

                          if (task == null) {
                            controller.addTasks(newtask);
                            Get.back();
                            Get.snackbar("Success", "Task Added");
                          } else {
                            controller.updateTask(newtask);
                            Get.back();
                            Get.snackbar("Success", "Task Updated");
                          }
                        } else {
                          Get.snackbar("Error", "Fill all fields");
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.blueAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        task == null ? "Add Task" : "Update Task",
                        style: textTheme.titleMedium
                            ?.copyWith(color: Colors.white),
                      ),
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
  
  

//   @override
//   Widget build(BuildContext context) {
//     final TaskController controller=Get.find();
//     final UserController usercntl=Get.find();

//     return Scaffold( 
//       appBar: AppBar(
//         title: TextWidget(text: 'Add Your tasks',),
//       ),
//       body:Padding(
//         padding: const EdgeInsets.all(24.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start, 
//           children: [ 
//             SizedBox(height: 20.h,),
//           buildCustomTextField(controller: titlecontroller, label: 'Add Task', icon: Icons.task),
//           SizedBox(height: 10,),
//           buildCustomTextField(controller: descriptioncontroller, label: 'Add Description', icon: Icons.description),
//            SizedBox(height: 20.h,),
//           Obx(() => DropdownButton<String>(
//   value: priority.value,
//   dropdownColor: Colors.grey[900],
//   items: ["High", "Medium", "Low"].map((p) => DropdownMenuItem(
//     value: p,
//     child: Text(p, style: TextStyle(color: Colors.white)),
//   )).toList(),
//   onChanged: (value) {
//     if (value != null) priority.value = value;
//   },
// )),
//          CustomButton(
//   onTap: () async{
//     final ThemeService pref=ThemeService();

//     final userId = await pref.getUserId();

//     if (userId == null) {
//       Get.snackbar("Error", "User not found");
//       return;
//     }

//     if (titlecontroller.text.isNotEmpty &&
//         descriptioncontroller.text.isNotEmpty) {

//       final newtask = Task(
//         id: task?.id, // only used for update
//         title: titlecontroller.text.trim(),
//         description: descriptioncontroller.text.trim(),
//         isCompleted: task?.isCompleted ?? false,
//         createdAt: DateTime.now().toIso8601String(),
//         userId: userId!,
//           priority: priority.value,
//       );

//       if (task == null) {
//         controller.addTasks(newtask);
//         Get.back();
//         Get.snackbar("Success", "Task Added");
//       } else {
//         controller.updateTask(newtask);
//         Get.back();
//         Get.snackbar("Success", "Task Updated");
//       }

//     } else {
//       Get.snackbar("Error", "Fill all fields");
//     }

//   },
//   text: task == null ? 'Add' : 'Update',
// )
//         ],),
//       ) ,
//     );
//   }
}