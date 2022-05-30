import 'package:deeptherapy/Doctor/Signup-Signin.dart';
import 'package:deeptherapy/repository/user_repository.dart';
import 'package:flutter/material.dart';
import 'authentication.dart';
import 'package:get/get.dart';
import '../../home/home_page.dart';
import '../../login/login_page.dart';
class OnBoard extends StatelessWidget {
  const OnBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserRepository userRepository = UserRepository();
    AuthenticationManager _authManager = Get.find();

    return Obx(() {
      return _authManager.isLogged.value ? HomePage() : LoginSignUp(key:Key('hi'), userRepository: userRepository,);
    });
  }
}