import 'package:everglo_mobile/app/modules/forgetPassword/controllers/forget_password_controller.dart';
import 'package:everglo_mobile/app/modules/forgetPassword/views/component/forget_password_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangePasswordView extends GetView<ForgetPasswordController> {
  ChangePasswordView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop,
          ),
        ),
        title: Text('Forget Password',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            )),
        centerTitle: true,
      ),
      body: Center(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: Text("Loading"),
            );
          } else {
            return Column(
              children: [
                SizedBox(
                  height: 115,
                  child: ForgetPasswordProgress(status: "change"),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 40),
                      child: Text(
                        "Identitas Anda telah diverifikasi! \nBuat password baru anda.",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        width: 327,
                        height: 50,
                        child: FormBuilderTextField(
                          // key: _emailFieldKey,
                          name: 'newPassword',
                          focusNode: controller.focusNode,
                          cursorColor: Color(0xFF00AD7C),
                          decoration: InputDecoration(
                            errorStyle: const TextStyle(fontSize: 0.01),
                            hintText: "New Password",
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
                                Icons.lock_outline,
                                color: controller.focusNode.hasFocus
                                    ? controller.focusedIconColor
                                    : controller.unfocusedIconColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF00AD7C)),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: 327,
                        height: 50,
                        child: FormBuilderTextField(
                          // key: _emailFieldKey,
                          name: 'confirmNewPassword',
                          focusNode: controller.focusNode,
                          cursorColor: Color(0xFF00AD7C),
                          decoration: InputDecoration(
                            errorStyle: const TextStyle(fontSize: 0.01),
                            hintText: "Confirm New Password",
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
                                Icons.lock_outline,
                                color: controller.focusNode.hasFocus
                                    ? controller.focusedIconColor
                                    : controller.unfocusedIconColor,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0xFF00AD7C)),
                                borderRadius: BorderRadius.circular(10)),
                          ),
                        ),
                      ),
                      SizedBox(height: 40),
                      MaterialButton(
                        onPressed: () => controller.onReady(),
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
                              "Send",
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
            );
          }
        }),
      ),
    );
  }
}
