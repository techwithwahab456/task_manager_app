import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/route_manager.dart';
import 'package:get/utils.dart';
import 'package:task_manager_app/app/services/pref_services.dart';
import 'package:task_manager_app/app/views/auth/loginScreen.dart';
import 'package:task_manager_app/common/constant/app_colors.dart';
import 'package:task_manager_app/common/constant/app_images.dart';
import 'package:task_manager_app/common/utils/custom_button.dart';
import 'package:task_manager_app/common/utils/text_widget.dart';

class Onboardingscreen extends StatelessWidget {
  const Onboardingscreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeService pref=ThemeService();
    return Scaffold( 
      body: Padding(padding: EdgeInsetsGeometry.all(24),
      child: Center(
        child: Column( 
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [ 
        
          TextWidget(text: 'Welcome to Task Manager',
          textType: TextType.headlineLarge,),
          SizedBox(height: 5,),
              TextWidget(text: 'Organize your tasks efficiently',
          textType: TextType.headlineSmall,),
          SizedBox(height: 40.h,),
          Container(
           
            height: 250.h,
            width: 300.w,
            decoration: BoxDecoration( 
              borderRadius: BorderRadius.circular(10.r),
              image: DecorationImage(image: AssetImage(AppImages.taskonboarding),
              fit: BoxFit.cover)
            ),
          
          ) ,
          SizedBox(height:60.h,),
          CustomButton( 
            containerColor: Colors.deepPurple,
            onTap: ()async{ 
            await pref.setOnBoardingSeen(true);

            
            Get.offAll(()=>Loginscreen());
          }, text: 'Get Started')
        ],),
      ),),
    );
  }
}