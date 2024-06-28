import 'package:everglo_mobile/app/data/models/Response.dart';
import 'package:everglo_mobile/app/data/repository/forgot_password.dart';
import 'package:everglo_mobile/app/helpers/notification_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class SendEmailController extends GetxController {
  final GlobalKey<FormBuilderState> formKey = GlobalKey();
  Rx<FocusNode> focusNode = FocusNode().obs;
  RxBool isPasswordHidden = true.obs;
  Rx<Color> focusedIconColor = const Color(0xFF00AD7C).obs;
  Rx<Color> unfocusedIconColor = const Color(0xFF8A8D90).obs;
  RxBool isLoading = false.obs;
  RxString email = ''.obs;

  validateEmail(String? email) {
    if (!GetUtils.isEmail(email ?? '')) {
      return 'Email is not valid';
    }
    return null;
  }

  Future<void> onSendEmail() async {
    isLoading.value = true;
    if (!formKey.currentState!.validate()) {
      Get.snackbar(
        'Feiled',
        'Send email failed',
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.red,
        margin: const EdgeInsets.fromLTRB(10, 30, 10, 0),
      );
      isLoading.value = false;
    } else {
      NotificationSnackbar()
          .success('Please wait', 'Your OTP is being sent to your email');
      handleSendEmail().then(
        (e) => {
          NotificationSnackbar().success('Success', e.message),
          Get.toNamed('/send-otp', arguments: {'email': email.value}),
          isLoading.value = false
        },
      );
    }
  }

  Future<ResponseSuccess> handleSendEmail() async {
    final response = await ForgotPasswordRepository().sendEmail(email.value);
    ResponseSuccess result = ResponseSuccess.fromJson(response);
    return result;
  }
}
