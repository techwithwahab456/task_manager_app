import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/instance_manager.dart';
import 'package:task_manager_app/app/controllers/theme_controller.dart';
import 'package:task_manager_app/common/utils/text_widget.dart';

class Settingpage extends StatelessWidget {
  const Settingpage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller=Get.put(ThemeController());
    return Scaffold( 
      appBar: AppBar(title: TextWidget(text: '',
      ), ),
      body: Padding(padding: EdgeInsetsGeometry.all(24),
      child: Column(children: [ 
        SizedBox(height: 30.h,),
        SwitchListTile(value:controller.isDarkMode.value , onChanged: (value) {
          controller.setTHeme();
        },)
      ],),),
    );
  }
}