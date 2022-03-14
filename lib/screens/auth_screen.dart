import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Controllers
import '../controllers/auth_controller.dart';

/// Utils
import '../utils/dimensions.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authController = Get.put<AuthController>(AuthController());

    return Scaffold(
      backgroundColor: Colors.orangeAccent.withOpacity(0.9),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: Dimensions.height40Percent,
              child: Center(
                child: Wrap(
                  children: [
                    Text(
                      'Sign',
                      style: TextStyle(
                        fontSize: Dimensions.height20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.width3,
                    ),
                    Text(
                      'In',
                      style: TextStyle(
                        fontSize: Dimensions.height18,
                        fontWeight: FontWeight.w600,
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35),
                  ),
                  color: Colors.white,
                ),
                child: Form(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  key: authController.loginFormKey,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: Dimensions.width20,
                        vertical: Dimensions.height20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextFormField(
                            decoration: const InputDecoration(
                              labelText: 'Username',
                              prefixIcon: Icon(Icons.person),
                            ),
                            validator: (val) {
                              return authController.validateUsername(val!);
                            },
                            onSaved: (val) {
                              authController.username.value = val!;
                            },
                          ),
                          SizedBox(
                            height: Dimensions.height15,
                          ),
                          Obx(
                            () => TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Password',
                                prefixIcon: const Icon(Icons.password),
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    authController.togglePassword();
                                  },
                                  icon: authController.hidePassword.value
                                      ? const Icon(Icons.visibility)
                                      : const Icon(Icons.visibility_off),
                                ),
                              ),
                              validator: (val) {
                                return authController.validatePassword(val!);
                              },
                              onSaved: (val) {
                                authController.password.value = val!;
                              },
                              obscureText: authController.hidePassword.value,
                            ),
                          ),
                          TextButton(
                            onPressed: () {},
                            child: const Text('Forgot password ?'),
                          ),
                          SizedBox(
                            height: Dimensions.height15,
                          ),
                          CircleAvatar(
                            radius: Dimensions.height30,
                            backgroundColor:
                                Colors.orangeAccent.withOpacity(0.9),
                            child: IconButton(
                              icon: const Icon(
                                Icons.arrow_right_alt,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                authController.signIn();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
