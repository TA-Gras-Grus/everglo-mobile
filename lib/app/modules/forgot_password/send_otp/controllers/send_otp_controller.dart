import 'dart:async';

import 'package:everglo_mobile/app/data/models/Response.dart';
import 'package:everglo_mobile/app/data/models/user.dart';
import 'package:everglo_mobile/app/data/repository/forgot_password.dart';
import 'package:everglo_mobile/app/helpers/notification_snackbar.dart';
import 'package:everglo_mobile/app/modules/forgot_password/send_email/controllers/send_email_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SendOtpController extends GetxController {
  final GlobalKey<FormBuilderState> formKey = GlobalKey();
  final SendEmailController sendEmailController = Get.find();
  Rx<GetStorage> storage = GetStorage().obs;
  Rx<User> user = User.fromJson({}).obs;

  Timer? _timer;
  Rx<FocusNode> focusNode = FocusNode().obs;
  RxBool isPasswordHidden = true.obs;
  Rx<Color> focusedIconColor = const Color(0xFF00AD7C).obs;
  Rx<Color> unfocusedIconColor = const Color(0xFF8A8D90).obs;
  RxBool isLoading = false.obs;
  RxString email = ''.obs;
  RxInt counter = 60.obs;

  @override
  void onInit() {
    email.value = Get.arguments['email'];
    super.onInit();
    startCounter();
  }

  Future<void> onSendOtp(String otp) async {
    isLoading.value = true;
    handleSendOtp(otp)
        .then(
          (e) => {
            user.value = User.fromJson(e.data),
            storage.value.write('userToken', user.value.token),
            NotificationSnackbar().success('Success', e.message),
            isLoading.value = false,
            Get.toNamed('/reset-password'),
          },
        )
        .onError((error, stackTrace) => {isLoading.value = false});
  }

  Future<ResponseSuccess> handleSendOtp(String otp) async {
    final response = await ForgotPasswordRepository().sendOtp(email.value, otp);
    ResponseSuccess result = ResponseSuccess.fromJson(response);
    return result;
  }

  Future<void> handleResendOtp() async {
    startCounter();
    NotificationSnackbar()
        .success('Please wait', 'Your OTP is being resent to your email');
    sendEmailController.handleSendEmail().then(
          (e) => {
            NotificationSnackbar()
                .success('Success', 'Your OTP has been resent to your email'),
          },
        );
  }

  startCounter() {
    _timer?.cancel(); // Cancel any existing timer
    counter.value = 59; // Reset the counter
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (counter.value > 0) counter.value -= 1;
    });
  }
}
