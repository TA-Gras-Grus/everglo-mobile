import 'package:everglo_mobile/app/helpers/ui_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';

import '../controllers/reset_password_controller.dart';

class ResetPasswordView extends GetView<ResetPasswordController> {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Obx(() {
            return Stack(
              children: [
                Image.asset('assets/images/splash.png'),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 90),
                        Image.asset('assets/images/bubbleLogo.png'),
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
                                            "Reset Password",
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
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 15),
                                          SizedBox(
                                            width: 327,
                                            height: 50,
                                            child: FormBuilderTextField(
                                              obscureText: true,
                                              name: 'password',
                                              initialValue:
                                                  controller.password.value,
                                              onChanged: (value) => {
                                                controller.password.value =
                                                    value ?? ''
                                              },
                                              focusNode:
                                                  controller.focusNode.value,
                                              cursorColor:
                                                  const Color(0xFF00AD7C),
                                              textAlignVertical:
                                                  TextAlignVertical.bottom,
                                              decoration: InputDecoration(
                                                errorStyle: const TextStyle(
                                                    fontSize: 0.01),
                                                hintText: "New Password",
                                                hintStyle: const TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xFFABB3BB),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                prefixIcon: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Icon(
                                                    Icons.lock_outline,
                                                    color: controller.focusNode
                                                            .value.hasFocus
                                                        ? controller
                                                            .unfocusedIconColor
                                                            .value
                                                        : controller
                                                            .focusedIconColor
                                                            .value,
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Color(0xFF00AD7C)),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              validator: (password) =>
                                                  controller.validatePassword(
                                                      password ?? ""),
                                            ),
                                          ),
                                          Text(
                                            controller.formKey.currentState
                                                    ?.errors['password'] ??
                                                "",
                                            style: TextStyle(
                                                color: Colors.red.shade900),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        FormBuilder(
                          key: controller.formKey2,
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(height: 15),
                                          SizedBox(
                                            width: 327,
                                            height: 50,
                                            child: FormBuilderTextField(
                                              obscureText: true,
                                              name: 'passwordConfirm',
                                              initialValue: controller
                                                  .passwordConfirm.value,
                                              onChanged: (value) => {
                                                controller.passwordConfirm
                                                    .value = value ?? ''
                                              },
                                              focusNode:
                                                  controller.focusNode2.value,
                                              cursorColor:
                                                  const Color(0xFF00AD7C),
                                              textAlignVertical:
                                                  TextAlignVertical.bottom,
                                              decoration: InputDecoration(
                                                errorStyle: const TextStyle(
                                                    fontSize: 0.01),
                                                hintText:
                                                    "New Password Confirmation",
                                                hintStyle: const TextStyle(
                                                  fontSize: 16,
                                                  color: Color(0xFFABB3BB),
                                                ),
                                                border: OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                prefixIcon: Padding(
                                                  padding: const EdgeInsets.all(
                                                      10.0),
                                                  child: Icon(
                                                    Icons.lock_outline,
                                                    color: controller.focusNode
                                                            .value.hasFocus
                                                        ? controller
                                                            .unfocusedIconColor
                                                            .value
                                                        : controller
                                                            .focusedIconColor
                                                            .value,
                                                  ),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Color(0xFF00AD7C)),
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                              ),
                                              validator: (password) =>
                                                  controller
                                                      .validatePasswordConfirm(
                                                          password ?? ""),
                                            ),
                                          ),
                                          Text(
                                            controller.formKey2.currentState
                                                        ?.errors[
                                                    'passwordConfirm'] ??
                                                "",
                                            style: TextStyle(
                                                color: Colors.red.shade900),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 50),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 0),
                      child: FilledButton(
                          onPressed: () {
                            controller.onSendPassword();
                          },
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
                            'Save Changes',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          )),
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
