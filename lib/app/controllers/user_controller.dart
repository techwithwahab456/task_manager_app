import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_app/app/models/user_model.dart';
import 'package:task_manager_app/app/services/database_services.dart';
import 'package:task_manager_app/app/services/pref_services.dart';

class UserController extends GetxController{ 
  var currentUser=Rxn<User>();
  var isLoggedIn=false.obs;
  final DatabaseServicess db=DatabaseServicess();
  final ThemeService thm=ThemeService();
  GlobalKey<FormState> formkey=GlobalKey();
  var ispasswordvisible=false.obs;
   var Signupispasswordvisible=false.obs;
 UserController({this.initialUserId});
  final int? initialUserId;
  @override
  void onInit() {
     if (initialUserId != null) {
      _loadUserInBackground();
    }
    // TODO: implement onInit
    super.onInit();
  }
 
   // Load user data in BACKGROUND, don't block UI
  void _loadUserInBackground() {
    Future.delayed(Duration(milliseconds: 100), () async {
      try {
        User? user = await db.getuserById(initialUserId!);
        if (user != null) {
          currentUser.value = user;
          isLoggedIn.value = true;
        } else {
          isLoggedIn.value = false;
        }
      } catch (e) {
        print('Error loading user: $e');
      }
    });
  }
  // void checkLoginStatus()async{ 
  //   int? userid=await thm.getUserId();
  //   if(userid!=null){ 
  //     User? user=await db.getuserById(userid);
  //     if(user!=null){ 
  //       currentUser.value=user;
  //       isLoggedIn.value=true;
  //     } else{ 
  //       isLoggedIn.value=false;
  //     }
  //   }else{ 
  //     isLoggedIn.value=false;
  //   }

  // }
  Future<bool> signup(String email,String password)async{ 
    User? existing=await db.getuserbyEmail(email);
    if(existing!=null){ 
      return false;
    }
    User newuser=User(email: email, password: password, createdAt: DateTime.now().toIso8601String());
    final id=await db.insertuser(newuser);
    newuser.id=id;
    currentUser.value=newuser;
    await thm.setUserId(id);
    isLoggedIn.value=true;
    return true;
  }
  Future<bool> login(String email,String password)async{ 
    User? user=await db.getuserbyEmail(email);
    if(user!=null&&user.password==password){ 
      currentUser.value=user;
      await thm.setUserId(user.id!);
      isLoggedIn.value=true;
      return true;
    }
    return false;
  }
}