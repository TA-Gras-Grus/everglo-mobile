import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  final _formKey = GlobalKey<FormBuilderState>();
  // Validate Input Error Message
  // String emailError = "";

  // void invalidEmail() {
  //   emailError = "This field cannot be empty";
  // }
  bool passToggle = true;

  LoginView({Key? key}) : super(key: key);

  // Validate Input Error Message Draft
  // bool validateInput() {
  //   try {
  //     if (email.isNotEmpty) {
  //       return true;
  //     } else {
  //       if (nameController.text.isEmpty) {
  //         invalidEmail();
  //       }
  //       return false;
  //     }
  //   } catch (e) {
  //     return false;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: Text('Loading'),
            );
          } else {
            return Stack(
              children: [
                Image.asset('assets/images/splash.png'),
                Container(
                  child: Padding(
                    padding: EdgeInsets.all(92),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/bubbleLogo.png'),
                        SizedBox(height: 9),
                        RichText(
                          text: TextSpan(
                              text: 'Welcome to Everglo',
                              style: GoogleFonts.poppins(
                                  fontSize: 20, fontWeight: FontWeight.w700)),
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
                          padding: EdgeInsets.only(top: 25.0),
                          child: Center(
                            child: Container(
                              width: 28,
                              height: 5,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color(0xFFBEBEBE)),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 30, left: 32),
                              child: Stack(
                                children: [
                                  Container(
                                    width: 332,
                                    height: 64,
                                    decoration: BoxDecoration(
                                        color: Color(0xFFEAECF0),
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
                                      child: Padding(
                                        padding:
                                            EdgeInsets.only(left: 2, top: 2),
                                        child: Center(
                                          child: Text(
                                            "Login",
                                            style: GoogleFonts.poppins(
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
                        SizedBox(
                          height: 24,
                        ),
                        FormBuilder(
                          key: _formKey,
                          child: Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(right: 190.0),
                                child: Text(
                                  "Email or Username",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(height: 15),
                              SizedBox(
                                width: 327,
                                height: 50,
                                child: FormBuilderTextField(
                                  // key: _emailFieldKey,
                                  name: 'email',
                                  focusNode: controller.focusNode,
                                  cursorColor: Color(0xFF00AD7C),
                                  decoration: InputDecoration(
                                    errorStyle: const TextStyle(fontSize: 0.01),
                                    hintText: "Enter your email",
                                    hintStyle: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: Color(0xFFABB3BB),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Icon(
                                        Icons.mail_outline,
                                        color: controller.focusNode.hasFocus
                                            ? controller.unfocusedIconColor
                                            : controller.focusedIconColor,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Color(0xFF00AD7C)),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  validator: (email) =>
                                      controller.validateEmail(email),
                                ),
                              ),
                              SizedBox(height: 20),
                              Padding(
                                padding: EdgeInsets.only(right: 250.0),
                                child: Text(
                                  "Password",
                                  style: GoogleFonts.poppins(
                                      fontSize: 14,
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(height: 15),
                              SizedBox(
                                width: 327,
                                height: 50,
                                child: FormBuilderTextField(
                                  name: 'password',
                                  obscureText:
                                      controller.isPasswordHidden.value,
                                  cursorColor: Color(0xFF00AD7C),
                                  decoration: InputDecoration(
                                    hintText: "Enter your password",
                                    hintStyle: GoogleFonts.poppins(
                                        fontSize: 16, color: Color(0xFFABB3BB)),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    prefixIcon: Padding(
                                      padding: EdgeInsets.all(10.0),
                                      child: Icon(Icons.lock_outline),
                                    ),
                                    suffixIcon: Padding(
                                      padding: EdgeInsets.only(right: 10.0),
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
                                        borderSide: BorderSide(
                                            color: Color(0xFF00AD7C)),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  ),
                                  validator: (pwd) =>
                                      controller.validatePassword(pwd),
                                ),
                              ),
                              SizedBox(height: 1),
                              Padding(
                                padding: EdgeInsets.only(left: 215.0),
                                child: TextButton(
                                  onPressed: () {},
                                  child: Text(
                                    "Forgot Password",
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w300,
                                      color: Color(0xFF00AD7C),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 145),
                              MaterialButton(
                                onPressed: () => controller.onLogin,
                                //Validate and save the form values
                                //   _formKey.currentState?.saveAndValidate();
                                //   debugPrint(
                                //       _formKey.currentState?.value.toString());
                                // },
                                child: Container(
                                  width: 327,
                                  height: 46,
                                  decoration: BoxDecoration(
                                    color: Color(0xFF52B788),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Sign In",
                                      style: GoogleFonts.poppins(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w600,
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
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
