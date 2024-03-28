import 'package:get/get.dart';
import 'package:flutter/material.dart';

class LoginController extends GetxController {
  //TODO: Implement LoginController
  final _formKey = GlobalKey<FormState>();
  final FocusNode focusNode = FocusNode();
  RxBool isLoading = false.obs;
  var isPasswordHidden = true.obs;
  final focusedIconColor = Color(0xFF00AD7C);
  final unfocusedIconColor = Color(0xFF8A8D90);

  @override
  void onInit() {
    super.onInit();
    focusNode.addListener(() {
      update();
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  // @override
  // void onClose() {
  //   focusNode.dispose();
  //   super.onClose();
  // }

  validateEmail(String? email) {
    if (!GetUtils.isEmail(email ?? '')) {
      return 'Email is not valid';
    }
    return null;
  }

  validatePassword(String? pwd) {
    if (GetUtils.isNullOrBlank(pwd ?? '') == null) {
      return 'Password is not valid';
    }
    return null;
  }

  Future onLogin() async {
    if (_formKey.currentState!.validate()) {
      Get.snackbar(
        'Success',
        'Login Successful',
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );
      return null;
    }
    Get.snackbar(
      'Error',
      'Login Unsuccessful',
      snackPosition: SnackPosition.BOTTOM,
      colorText: Colors.white,
      backgroundColor: Colors.red,
    );
  }
}
