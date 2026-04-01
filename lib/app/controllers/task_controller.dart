import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:task_manager_app/app/controllers/user_controller.dart';
import 'package:task_manager_app/app/models/task_model.dart';
import 'package:task_manager_app/app/services/database_services.dart';
import 'package:task_manager_app/app/services/notifucation_service.dart';


class TaskController extends GetxController { 
  var tasks=<Task>[].obs;
    bool _tasksLoaded = false;
  var searchText=''.obs;
  var filterType=''.obs;
  final DatabaseServicess db=DatabaseServicess();
  final UserController usercntl=Get.find();
  final SpeechToText speech = SpeechToText();
var isListening = false.obs;
Rx<DateTime?> selectedDate = Rx<DateTime?>(null);
  @override
  void onInit() {
    // Step 1: Check permissions FIRST
  //  checkNotificationPermission();
    
    // Step 2: Don't fetch tasks during init
    // Instead, fetch them AFTER permission dialog closes
    super.onInit();
    
    // Step 3: Listen for user changes
    ever(usercntl.currentUser, (user) {
      if (user != null && !_tasksLoaded) {
        // Delay to avoid running while dialogs are open
        Future.delayed(Duration(seconds: 1), () {
          FetchTasks(user.id!);
          _tasksLoaded = true;
        });
      }
    });
     Future.delayed(Duration(milliseconds: 300), () {
      checkNotificationPermission();
  });}
  
  // 1. Define this variable OUTSIDE your function (at the class level)
bool _hasCheckedPermissions = false;
Future<void> checkNotificationPermission() async {
  if (_hasCheckedPermissions) return;
  _hasCheckedPermissions = true; // Set FIRST to prevent any re-entry

  // Step 1: Request notification permission and WAIT for user response
  var notifStatus = await Permission.notification.status;
  if (notifStatus.isDenied) {
    await Permission.notification.request(); // This is already awaited ✅
  }

  // Step 2: Only check exact alarm AFTER notification dialog is fully done
  if (Platform.isAndroid) {
    // Add a small gap between the two dialogs
    await Future.delayed(Duration(milliseconds: 1000));
    
    PermissionStatus exactStatus = await Permission.scheduleExactAlarm.status;
    if (!exactStatus.isGranted) {
      Get.defaultDialog(
        title: "One-Time Setup",
        middleText: "Ensure 'Alarms & Reminders' is enabled in your phone's Special App Access for timely tasks.",
        textConfirm: "Settings",
        textCancel: "Done",
        onConfirm: () {
          openAppSettings();
          Get.back();
        },
        onCancel: () => Get.back(),
      );
    }
  }
}
//   Future<void> checkNotificationPermission() async {
//   // Check notification permission
//   var notifStatus = await Permission.notification.status;

//   if (!notifStatus.isGranted) {
//     // Ask user first
//     var result = await Permission.notification.request();

//     if (!result.isGranted) {
//       // Permission denied permanently or temporarily, show UI to go to settings
//       Get.defaultDialog(
//         title: "Enable Notifications",
//         middleText:
//             "Please enable notifications in app settings to get task reminders.",
//         textConfirm: "Open Settings",
//         textCancel: "Cancel",
//         onConfirm: () {
//           openAppSettings(); // Opens the device settings for this app
//           Get.back(); // Close the dialog
//         },
//       );
//       return;
//     }
//   }

//   // Exact alarm permission for Android 12+
//   if (Platform.isAndroid) {
//     bool exact = await NotificationService.requestExactAlarmPermission();
//     if (!exact) {
//       Get.defaultDialog(
//         title: "Enable Exact Alarm",
//         middleText:
//             "Exact alarm permission is needed for timely task notifications. Please enable in settings.",
//         textConfirm: "Open Settings",
//         textCancel: "Cancel",
//         onConfirm: () {
//           openAppSettings();
//           Get.back();
//         },
//       );
//     }
//   }
// }

// Future<void> checkNotificationPermission() async {
//   // Request notification permission
//   var notifStatus = await Permission.notification.status;
//   if (!notifStatus.isGranted) {
//     bool granted = await Permission.notification.request().isGranted;
//     if (!granted) {
//       // Show a snackbar asking user to enable in settings
//       Get.snackbar(
//         "Permission required",
//         "Please enable notification permission in settings to get task reminders",
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       return;
//     }
//   }

//   // Request exact alarm permission for Android 12+
//   if (Platform.isAndroid) {
//     bool exact = await NotificationService.requestExactAlarmPermission();
//     if (!exact) {
//       Get.snackbar(
//         "Exact alarm denied",
//         "Notifications may be delayed. Enable exact alarms in settings for timely reminders",
//         snackPosition: SnackPosition.BOTTOM,
//       );
//     }
//   }
// }
  List get filteredTasks {
  return tasks.where((task) {
    final matchesSearch = task.title
        .toLowerCase()
        .contains(searchText.value.toLowerCase());

    bool matchesFilter = true;

    if (filterType.value == 'completed') {
      matchesFilter = task.isCompleted;
    } else if (filterType.value == 'pending') {
      matchesFilter = !task.isCompleted;
    }

    return matchesSearch && matchesFilter;
  }).toList();
}
String get pendingMessage {
  final pendingCount = tasks.where((t) => !t.isCompleted).length;
  if (pendingCount == 0) return "All tasks completed! 🎉";
  if (pendingCount <= 3) return "You have $pendingCount pending task(s)";
  return "You have $pendingCount tasks pending, focus on High priority!";
}
double get completionPercent {
  if (tasks.isEmpty) return 0;
  int completedCount = tasks.where((t) => t.isCompleted).length;
  return completedCount / tasks.length;
}
  void logOut()async{ 
    await db.logoutUser(usercntl.currentUser.value!.id!);
  }
   // Load tasks in the BACKGROUND without blocking UI
 void FetchTasks(int userId) async {
  try {
    final loadedTasks = await db.getTasks(userId);
    tasks.assignAll(loadedTasks);
  } catch (e) {
    print('Error fetching tasks: $e');
  }
}
  
 
 //Future<List<Task>> _loadTasksFromDb(int userId) async {
//   final db = DatabaseServicess();
//   final tasks = await db.getTasks(userId);
//   return tasks;
// }
   
      // if (usercntl.currentUser.value != null) {
      //   try {
      //     final loadtasks = await db.getTasks(usercntl.currentUser.value!.id!);
      //     tasks.assignAll(loadtasks);
      //   } catch (e) {
      //     print('Error fetching tasks: $e');
      //   }
      // }
    
  
  
  // For manual refresh (user pulls to refresh)
  Future<void> refreshTasks() async {
    if (usercntl.currentUser.value != null) {
      final loadtasks = await db.getTasks(usercntl.currentUser.value!.id!);
      tasks.assignAll(loadtasks);
    }
  }
  // void FetchTasks()async{ 
  //   if(usercntl.currentUser.value!=null){
  //  final loadtasks= await db.getTasks(usercntl.currentUser.value!.id!);
  //    tasks.assignAll(loadtasks); }
  //  }

  // void addTasks(Task task) async {
  // final user = usercntl.currentUser.value;

  // if (user == null) {
  //   Get.snackbar("Error", "User not loaded yet");
  //   return;
  // }

//   task.userId = user.id!;
//   await db.insertTasks(task);
//   FetchTasks();
// // }
// void addTasks(Task task) async {
//   final user = usercntl.currentUser.value;
//   if (user == null) {
//     Get.snackbar("Error", "User not loaded yet");
//     return;
//   }

//   task.userId = user.id!;
//   task.priority = task.priority; // <-- make sure this is set
// int taskId=  await db.insertTasks(task);
//   FetchTasks();
//    if (task.deadline != null && task.deadline!.isAfter(DateTime.now())) {
//      int notifId = (task.id ?? DateTime.now().millisecondsSinceEpoch) & 0x7FFFFFFF;
//      task.id = taskId;
//     NotificationService.scheduleNotification(
//       taskId,
//         task.title,
//         "Task deadline at ${task.deadline}",
//         task.deadline!,
      

//     );
//   }
// }
void addTasks(Task task) async {
  final user = usercntl.currentUser.value;
  if (user == null) return;

  task.userId = user.id!;
  
  // 1. Wait for the database to return the actual auto-incremented ID
  int taskId = await db.insertTasks(task); 
  task.id = taskId; // Sync the model with the DB ID
  
  FetchTasks(user.id!);

  if (task.deadline != null && task.deadline!.isAfter(DateTime.now())) {
    // 2. Ensure the ID is a safe 32-bit integer
    int safeNotifId = taskId & 0x7FFFFFFF;

    print("Scheduling Notification for Task ID: $taskId at ${task.deadline}");

    await NotificationService.scheduleNotification(
      safeNotifId, // Use the safe ID here!
      task.title,
      "Deadline: ${task.title}",
      task.deadline!,
    );
  }
}
  void updateTask(Task task)async    { 
    final user = usercntl.currentUser.value;
    if (user == null) return;
    await db.updateTask(task);
    FetchTasks(user.id!);
     await NotificationService.cancelNotification(task.id!);
  if (task.deadline != null && task.deadline!.isAfter(DateTime.now())) {
     int notifId = (task.id ?? DateTime.now().millisecondsSinceEpoch) & 0x7FFFFFFF;
    NotificationService.scheduleNotification(
      notifId,
      task.title,
      "Task deadline at ${task.deadline}",
        task.deadline!,
    );
  }
  }
  void deleteTask(int id)async{
    final user = usercntl.currentUser.value;
    if (user == null) return; 
    await db.deleteTask(id);
    FetchTasks(user.id!);
      await NotificationService.cancelNotification(id);
  }
  void toggleCompletion(Task task)async{ 
    task.isCompleted=!task.isCompleted;
    updateTask(task);
  }
}
