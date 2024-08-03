import 'package:everglo_mobile/app/data/models/Response.dart';
import 'package:everglo_mobile/app/data/repository/forgot_password.dart';
import 'package:everglo_mobile/app/helpers/notification_snackbar.dart';
import 'package:everglo_mobile/app/helpers/ui_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class ResetPasswordController extends GetxController {
  final GlobalKey<FormBuilderState> formKey = GlobalKey();
  final GlobalKey<FormBuilderState> formKey2 = GlobalKey();
  Rx<FocusNode> focusNode = FocusNode().obs;
  Rx<FocusNode> focusNode2 = FocusNode().obs;
  RxBool isPasswordHidden = true.obs;
  Rx<Color> focusedIconColor = UiColor().primary.obs;
  Rx<Color> unfocusedIconColor = Colors.black45.obs;
  RxBool isLoading = false.obs;
  RxString password = ''.obs;
  RxString passwordConfirm = ''.obs;

  String? validatePassword(String value) {
    RegExp regex = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$');
    if (value.isEmpty) {
      return 'Please enter password';
    } else {
      if (!regex.hasMatch(value)) {
        return 'Enter valid password';
      } else {
        return null;
      }
    }
  }

  String? validatePasswordConfirm(String value) {
    if (value.isEmpty) {
      return 'Please enter password confirmation';
    } else {
      if (value != password.value) {
        return 'Pasword confirmation must match';
      } else {
        return null;
      }
    }
  }


  Future<void> onSendPassword() async {
    isLoading.value = true;
    if (!formKey.currentState!.validate() ||
        !formKey2.currentState!.validate()) {
      Get.snackbar(
        'Feiled',
        'Please fill the fields correctly',
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.red,
        margin: const EdgeInsets.fromLTRB(10, 30, 10, 0),
      );
      isLoading.value = false;
    } else {
      handleSendPassword().then((value) => {
            NotificationSnackbar().success(
                'Success', 'Your password has been changed successfully'),
            Get.offAllNamed('/login')
          });
    }
  }

  Future<ResponseSuccess> handleSendPassword() async {
    final response = await ForgotPasswordRepository()
        .resetPassword(password.value, passwordConfirm.value);
    ResponseSuccess result = ResponseSuccess.fromJson(response);
    return result;
  }
}
