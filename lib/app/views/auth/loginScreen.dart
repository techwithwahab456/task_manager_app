import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:task_manager_app/app/controllers/user_controller.dart';
import 'package:task_manager_app/app/views/auth/signup_screen.dart';
import 'package:task_manager_app/app/views/homepage.dart';
import 'package:task_manager_app/common/constant/app_colors.dart';
import 'package:task_manager_app/common/utils/custom_button.dart';
import 'package:task_manager_app/common/utils/custom_textfield.dart';
import 'package:task_manager_app/common/utils/text_widget.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({super.key});

  @override
  State<Loginscreen> createState() => _LoginscreenState();
}

class _LoginscreenState extends State<Loginscreen> {
     final TextEditingController emailcntl=TextEditingController();
    final TextEditingController passwordcntl=TextEditingController();
    final UserController usercntl=Get.find();
  @override
  Widget build(BuildContext context) {
 
    return Scaffold( 
     
      body: Padding(padding: EdgeInsetsGeometry.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        
        children: [
          TextWidget(text: 'Login Screen',
          textType: TextType.headlineLarge,),
          Center(child: Card(
            shadowColor: Colors.amber,
            shape: BeveledRectangleBorder(borderRadius: BorderRadiusGeometry.circular(10),
            side: BorderSide( 
              color: AppColors.pendingColor
            )), 
            child: Form(
              key: usercntl.formkey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column( 
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [ 
                    SizedBox(height: 20.h,),
                  buildCustomTextField( 
                    
                    
                    controller: emailcntl, label: 'Enter Email', icon: Icons.email,
                  validator: (Value) { 
                    if(Value==null || Value.isEmpty){ 
                      return 'Please Enter email ';
                    }if(!Value.contains('@')){ 
                      return 'Please enter correct email';
                    }
                    return null;
                  } ,),
                  SizedBox(height: 15.h,),
                  buildCustomTextField( 
                    isPassword: true,
                    controller: passwordcntl, label: 'Enter Password', icon: Icons.password,
                   validator: (Value) { 
                    if(Value==null|| Value.isEmpty){ 
                      return 'Please enter password';
                    }if(Value.length<6){ 
                      return 'Please put Password upto 8 charactters';
                    }
                    return null;
                  } ),
                  SizedBox(height: 25.h,),
                  CustomButton(onTap: ()async{ 
                    if(usercntl.formkey.currentState!.validate()){
                  bool success= await usercntl.login(emailcntl.text, passwordcntl.text);
                  if(success){ 
                  Get.offAll(()=>Homepage());
                  }else{ 
                    Get.snackbar('Error', 'Please enter text and password first!');
                  }}
                  }, text: 'Login'),
                    SizedBox(height: 10,),
                  GestureDetector(
                    onTap: () {
                      Get.offAll(SignupScreen());
                    },
                    child: Text.rich(TextSpan( 
                      children: [ 
                        TextSpan(text: 'Dont have an Account? '),
                        TextSpan(text: 'SignUp',
                       )
                        
                      ]
                    )),
                  )
                ],),
              ),
            ),
          ),),
        ],
      ),),
    );
  }
}