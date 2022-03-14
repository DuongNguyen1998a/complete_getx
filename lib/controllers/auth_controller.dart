import 'package:flutter/material.dart';
import 'package:flutter_complete_getx/screens/home_screen.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final loginFormKey = GlobalKey<FormState>();
  var hidePassword = true.obs;
  
  var username = ''.obs;
  var password = ''.obs;

  void togglePassword() {
    hidePassword.value = !hidePassword.value;
  }

  String? validateUsername(String username) {
    if (GetUtils.isUsername(username)) {
      return null;
    } else {
      return 'Username is valid, please try again.';
    }
  }

  String? validatePassword(String password) {
    if (password.isEmpty) {
      return 'Password is valid, please try again.';
    } else if (password.length < 5) {
      return 'Password too weak, must be > 5 characters.';
    } else {
      return null;
    }
  }

  void signIn() {
    if (!loginFormKey.currentState!.validate()) {
      return;
    } else {
      loginFormKey.currentState!.save();

      // close keyboard
      FocusManager.instance.primaryFocus!.unfocus();

      if (username.compareTo('duong') == 0 &&
          password.compareTo('123456') == 0) {
        Get.off(() => const HomeScreen());
      } else {
        Get.snackbar(
          'Error when sign in',
          'Sign in failed with username or password.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.black,
          colorText: Colors.white,
          mainButton: TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text(
              'Ok',
              style: TextStyle(color: Colors.orangeAccent),
            ),
          ),
        );
      }
    }
  }
}
