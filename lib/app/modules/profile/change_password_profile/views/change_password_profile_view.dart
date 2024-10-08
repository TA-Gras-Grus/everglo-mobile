import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/change_password_profile_controller.dart';

class ChangePasswordProfileView
    extends GetView<ChangePasswordProfileController> {
  const ChangePasswordProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        backgroundColor: const Color(0xFFF6F6F6),
        leading: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 18, top: 10, bottom: 10),
          child: Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey
                      .withOpacity(0.2), // Adjust opacity for shadow intensity
                  blurRadius: 10.0, // Adjust blur radius for shadow softness
                  spreadRadius: 1.0, // Adjust spread radius for shadow size
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black, size: 18),
              onPressed: () => Navigator.pop(Get.context!),
            ),
          ),
        ),
        title: Text('Change Password',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            )),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: Text('Loading...'),
          );
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5, top: 15),
                    child: FormBuilder(
                      key: controller.formKey,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right: 240.0),
                            child: Text(
                              "Old Password",
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: SizedBox(
                              width: 353,
                              height: 50,
                              child: FormBuilderTextField(
                                name: 'oldPassword',
                                obscureText:
                                    controller.isOldPasswordHidden.value,
                                cursorColor: const Color(0xFF00AD7C),
                                onChanged: (value) =>
                                    controller.oldPassword.value = value ?? "",
                                decoration: InputDecoration(
                                  hintText: "Enter your old password",
                                  hintStyle: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Icon(Icons.lock_outline),
                                  ),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: InkWell(
                                      child: Icon(
                                        controller.isOldPasswordHidden.value
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                      onTap: () {
                                        controller.isOldPasswordHidden.value =
                                            !controller
                                                .isOldPasswordHidden.value;
                                      },
                                    ),
                                  ),
                                  errorStyle: const TextStyle(fontSize: 0.01),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0xFF00AD7C)),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                validator: (old) =>
                                    controller.validateOldPassword(old ?? ""),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 24),
                                child: Text(
                                  controller.formKey.currentState
                                          ?.errors['oldPassword'] ??
                                      "",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.red.shade900,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.only(right: 240.0),
                            child: Text(
                              "New Password",
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: SizedBox(
                              width: 353,
                              height: 50,
                              child: FormBuilderTextField(
                                name: 'newPassword',
                                obscureText: controller.isPasswordHidden.value,
                                cursorColor: const Color(0xFF00AD7C),
                                onChanged: (value) =>
                                    controller.password.value = value ?? "",
                                decoration: InputDecoration(
                                  hintText: "Enter your new password",
                                  hintStyle: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Icon(Icons.lock_outline),
                                  ),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: InkWell(
                                      child: Icon(
                                        controller.isPasswordHidden.value
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                      onTap: () {
                                        controller.isPasswordHidden.value =
                                            !controller.isPasswordHidden.value;
                                      },
                                    ),
                                  ),
                                  errorStyle: const TextStyle(fontSize: 0.01),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0xFF00AD7C)),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                validator: (newPass) =>
                                    controller.validatePassword(newPass ?? ""),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 24),
                                child: Text(
                                  controller.formKey.currentState
                                          ?.errors['newPassword'] ??
                                      "",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.red.shade900,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.only(right: 140.0),
                            child: Text(
                              "New Password Confirmation",
                              style: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          const SizedBox(height: 15),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: SizedBox(
                              width: 353,
                              height: 50,
                              child: FormBuilderTextField(
                                name: 'newPasswordConfirm',
                                obscureText:
                                    controller.isPasswordConfirmHidden.value,
                                cursorColor: const Color(0xFF00AD7C),
                                onChanged: (value) => controller
                                    .passwordConfirm.value = value ?? "",
                                decoration: InputDecoration(
                                  hintText:
                                      "Enter your new password confirmation",
                                  hintStyle: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  prefixIcon: const Padding(
                                    padding: EdgeInsets.all(10.0),
                                    child: Icon(Icons.lock_outline),
                                  ),
                                  suffixIcon: Padding(
                                    padding: const EdgeInsets.only(right: 10.0),
                                    child: InkWell(
                                      child: Icon(
                                        controller.isPasswordConfirmHidden.value
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                      onTap: () {
                                        controller
                                                .isPasswordConfirmHidden.value =
                                            !controller
                                                .isPasswordConfirmHidden.value;
                                      },
                                    ),
                                  ),
                                  errorStyle: const TextStyle(fontSize: 0.01),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: Color(0xFF00AD7C)),
                                      borderRadius: BorderRadius.circular(10)),
                                ),
                                validator: (newPassConfirm) =>
                                    controller.validatePasswordConfirm(
                                        newPassConfirm ?? ""),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 24),
                                child: Text(
                                  controller.formKey.currentState
                                          ?.errors['newPasswordConfirm'] ??
                                      "",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: Colors.red.shade900,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 300),
                          MaterialButton(
                            onPressed: () => controller.onChangePassword(),
                            child: Container(
                              width: 343,
                              height: 46,
                              decoration: BoxDecoration(
                                color: const Color(0xFF52B788),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  "Save Changes",
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
                  ),
                ],
              ),
            ),
          );
        }
      }),
    );
  }

  Widget changedPasswordBottomSheet(BuildContext context) => Container(
        height: 402,
        width: 393,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30, bottom: 12),
                width: 132,
                height: 132,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset('assets/images/updated.png'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 18),
                child: Text(
                  'Password Changed!',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35, right: 30, bottom: 24),
                child: Text(
                  'Your password has been successfully changed, changes are reflected real time.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF838FA0),
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () => Navigator.pop(Get.context!),
                child: Container(
                  margin: const EdgeInsets.only(left: 14, right: 5),
                  height: 50,
                  width: 327,
                  decoration: BoxDecoration(
                    color: const Color(0xFF52B788),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      'Confirm',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget failedChangePasswordBottomSheet(BuildContext context) => Container(
        height: 468,
        width: 393,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30, bottom: 12),
                width: 132,
                height: 132,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset('assets/images/failed.png'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 14),
                child: Text(
                  'Password Change Failed',
                  style: GoogleFonts.poppins(
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35, right: 30, bottom: 18),
                child: Text(
                  'Oops, there are something wrong with changing password, please try again in a moment.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF838FA0),
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () => Navigator.pop(Get.context!),
                child: Container(
                  margin: const EdgeInsets.only(left: 14, right: 5),
                  height: 50,
                  width: 327,
                  decoration: BoxDecoration(
                    color: const Color(0xFF52B788),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      'Try Again',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              MaterialButton(
                onPressed: () => Navigator.pop(Get.context!),
                child: Container(
                  margin: const EdgeInsets.only(left: 14, right: 5),
                  height: 50,
                  width: 327,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(
                              0.2), // Adjust opacity for shadow intensity
                          blurRadius:
                              10.0, // Adjust blur radius for shadow softness
                          spreadRadius:
                              1.0, // Adjust spread radius for shadow size
                        ),
                      ]),
                  child: Center(
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF52B788),
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
