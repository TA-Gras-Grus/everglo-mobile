import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangePasswordProfileController extends GetxController {
  //TODO: Implement ChangePasswordProfileController
  RxBool isLoading = false.obs;
  final count = 0.obs;

  final _formKey = GlobalKey<FormState>();
  final FocusNode focusNode = FocusNode();
  var isPasswordHidden = true.obs;
  final focusedIconColor = Color(0xFF00AD7C);
  final unfocusedIconColor = Color(0xFF8A8D90);
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  validatePassword(String? pwd) {
    if (GetUtils.isNullOrBlank(pwd ?? '') == null) {
      return 'Password is not valid';
    }
    return null;
  }

  Future onChanged() async {
    // if (_formKey.currentState!.validate()) {
    //   Get.snackbar(
    //     'Success',
    //     'Login Successful',
    //     snackPosition: SnackPosition.BOTTOM,
    //     colorText: Colors.white,
    //     backgroundColor: Colors.green,
    //   );
    //   return null;
    // }
    // Get.snackbar(
    //   'Error',
    //   'Login Unsuccessful',
    //   snackPosition: SnackPosition.BOTTOM,
    //   colorText: Colors.white,
    //   backgroundColor: Colors.red,
    // );
  }

  void increment() => count.value++;
}
