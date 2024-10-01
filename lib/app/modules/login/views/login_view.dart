import 'package:everglo_mobile/app/helpers/ui_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Obx(() {
            return Stack(
              children: [
                Image.asset('assets/images/splash.jpg'),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 90),
                        Image.asset('assets/images/everglo_new.png',
                            width: 100),
                        const SizedBox(height: 9),
                        RichText(
                          text: const TextSpan(
                            text: 'Welcome to Everglo',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 240,
                  right: 0,
                  left: 0,
                  child: Container(
                    height: 613,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(28),
                        topRight: Radius.circular(28),
                      ),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: Center(
                            child: Container(
                              width: 28,
                              height: 5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: const Color(0xFFBEBEBE)),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(top: 30, left: 32),
                              child: Stack(
                                children: [
                                  Container(
                                    width: 332,
                                    height: 64,
                                    decoration: BoxDecoration(
                                        color: const Color(0xFFEAECF0),
                                        borderRadius:
                                            BorderRadius.circular(32)),
                                  ),
                                  Positioned(
                                    top: 8,
                                    right: 12,
                                    child: Container(
                                      width: 308,
                                      height: 48,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(32)),
                                      child: const Padding(
                                        padding:
                                            EdgeInsets.only(left: 2, top: 2),
                                        child: Center(
                                          child: Text(
                                            "Login",
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        FormBuilder(
                          key: controller.formKey,
                          child: Column(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(right: 190.0),
                                child: Text(
                                  "Email or Username",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 15),
                              SizedBox(
                                width: 327,
                                height: 50,
                                child: FormBuilderTextField(
                                  name: 'email',
                                  initialValue: controller.email.value,
                                  onChanged: (value) =>
                                      {controller.email.value = value ?? ''},
                                  focusNode: controller.focusNode.value,
                                  cursorColor: const Color(0xFF00AD7C),
                                  textAlignVertical: TextAlignVertical.bottom,
                                  decoration: InputDecoration(
                                    errorStyle: const TextStyle(fontSize: 0.01),
                                    hintText: "Enter your email",
                                    hintStyle: const TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFFABB3BB),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Icon(
                                        Icons.mail_outline,
                                        color: controller
                                                .focusNode.value.hasFocus
                                            ? controller
                                                .unfocusedIconColor.value
                                            : controller.focusedIconColor.value,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xFF00AD7C)),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  validator: (email) =>
                                      controller.validateEmail(email),
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Padding(
                                padding: EdgeInsets.only(right: 250.0),
                                child: Text("Password",
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700)),
                              ),
                              const SizedBox(height: 15),
                              SizedBox(
                                width: 327,
                                height: 50,
                                child: FormBuilderTextField(
                                  name: 'password',
                                  initialValue: controller.password.value,
                                  onChanged: (value) =>
                                      {controller.password.value = value ?? ''},
                                  obscureText:
                                      controller.isPasswordHidden.value,
                                  cursorColor: const Color(0xFF00AD7C),
                                  textAlignVertical: TextAlignVertical.bottom,
                                  decoration: InputDecoration(
                                    hintText: "Enter your password",
                                    hintStyle: const TextStyle(
                                        fontSize: 16, color: Color(0xFFABB3BB)),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Icon(
                                        Icons.lock_outline,
                                        color: UiColor().btnPrimary,
                                      ),
                                    ),
                                    suffixIcon: Padding(
                                      padding:
                                          const EdgeInsets.only(right: 10.0),
                                      child: InkWell(
                                        child: Icon(
                                          controller.isPasswordHidden.value
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                        ),
                                        onTap: () {
                                          controller.isPasswordHidden.value =
                                              !controller
                                                  .isPasswordHidden.value;
                                        },
                                      ),
                                    ),
                                    errorStyle: const TextStyle(fontSize: 0.01),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xFF00AD7C)),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  validator: (pwd) =>
                                      controller.validatePassword(pwd),
                                ),
                              ),
                              const SizedBox(height: 1),
                              Padding(
                                padding: const EdgeInsets.only(left: 215.0),
                                child: TextButton(
                                  onPressed: () {
                                    Get.toNamed('/send-email');
                                  },
                                  child: const Text(
                                    "Forgot Password",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300,
                                      color: Color(0xFF00AD7C),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 100),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 0),
                                child: FilledButton(
                                    onPressed: () => controller.onLogin(),
                                    style: FilledButton.styleFrom(
                                      minimumSize: const Size(
                                        double.infinity,
                                        48,
                                      ),
                                      backgroundColor: UiColor().btnPrimary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text(
                                      'Sign In',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    )),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
