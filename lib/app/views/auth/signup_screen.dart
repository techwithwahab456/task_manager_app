import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:task_manager_app/app/controllers/user_controller.dart';
import 'package:task_manager_app/app/views/auth/loginScreen.dart';
import 'package:task_manager_app/app/views/homepage.dart';
import 'package:task_manager_app/common/utils/custom_button.dart';
import 'package:task_manager_app/common/utils/custom_textfield.dart';
import 'package:task_manager_app/common/utils/glass_card.dart';
import 'package:task_manager_app/common/utils/text_widget.dart';
import 'package:task_manager_app/theme/theme_extension.dart';
class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {

  final emailcntl = TextEditingController();
  final passwordcntl = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // ✅ separate key

  final UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
      final themeColors = Theme.of(context).extension<AppThemeExtension>()!;
  final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      // appBar: AppBar( 
      //   backgroundColor: themeColors.containerGradientStart,

      //   actions: [  IconButton(
      //                 onPressed: () => Get.back(),
      //                 icon: Icon(Icons.arrow_back,
      //                     color: textTheme.bodyMedium?.color),
      //               )],),
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
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                
          
              TextWidget(
                text: 'Register Your Account!',
                textType: TextType.headlineLarge,
              ),
          
              SizedBox(height: 20),
          
              Center(
                child: glassCard(
                  themeColors: themeColors,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Form(
                      key: _formKey, // ✅ FIXED
                      child: Column(
                        children: [
                
                          buildCustomTextField(
                               context: context,
                            controller: emailcntl,
                            label: 'Enter Email',
                            icon: Icons.email,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Enter email';
                              }
                              if (!value.contains('@')) {
                                return 'Invalid email';
                              }
                              return null;
                            },
                          ),
                
                          SizedBox(height: 15),
                
                          Obx(()=>
                             buildCustomTextField(
                              isPassword: true,
                              visibility: userController.Signupispasswordvisible.value,
                              suffixIcon: userController.Signupispasswordvisible.value?Icons.visibility:Icons.visibility_off,
                              onPressedSuffixIcon: () {
                                userController.Signupispasswordvisible.toggle();
                              },
                                 context: context,
                              controller: passwordcntl,
                              label: 'Enter Password',
                              icon: Icons.password,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter password';
                                }
                                if (value.length < 6) {
                                  return 'Min 6 characters'; // ✅ fixed message
                                }
                                return null;
                              },
                            ),
                          ),
                
                          SizedBox(height: 25),
                
                          CustomButton(
                            onTap: () async {
                
                              if (_formKey.currentState!.validate()) {
                
                                bool success = await userController.signup(
                                  emailcntl.text.trim(),
                                  passwordcntl.text.trim(),
                                );
                
                                if (success) {
                                  Get.offAll(() => Homepage());
                                } else {
                                  Get.snackbar('Error', 'User already exists');
                                }
                
                              }
                
                            },
                            text: 'Signup',
                          ),
                
                          SizedBox(height: 10),
                
                          GestureDetector(
                            onTap: () {
                              Get.to(() => Loginscreen()); // ✅ FIXED
                            },
                            child: Text("Already have an account? Login"),
                          )
                
                        ],
                      ),
                    ),
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