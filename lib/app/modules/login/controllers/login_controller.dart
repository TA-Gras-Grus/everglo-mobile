import 'dart:async';

import 'package:everglo_mobile/app/data/models/response.dart';
import 'package:everglo_mobile/app/data/models/user.dart';
import 'package:everglo_mobile/app/data/repository/auth_repository.dart';
import 'package:everglo_mobile/app/helpers/notification_snackbar.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

class LoginController extends GetxController {
  final GlobalKey<FormBuilderState> formKey = GlobalKey();
  Rx<FocusNode> focusNode = FocusNode().obs;
  RxBool isPasswordHidden = true.obs;
  Rx<Color> focusedIconColor = const Color(0xFF00AD7C).obs;
  Rx<Color> unfocusedIconColor = const Color(0xFF8A8D90).obs;
  Rx<GetStorage> storage = GetStorage().obs;
  RxBool isLoading = false.obs;
  RxString email = ''.obs;
  RxString password = ''.obs;

  @override
  void onInit() {
    super.onInit();
    focusNode.value.addListener(() {
      update();
    });
  }

  @override
  void dispose() {
    focusNode.value.dispose();
    super.dispose();
  }

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

  Future<void> onLogin() async {
    isLoading.value = true;
    if (!formKey.currentState!.validate()) {
      Get.snackbar(
        'Error',
        'Login Unsuccessful',
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.red,
        margin: const EdgeInsets.fromLTRB(10, 30, 10, 0),
      );
    } else {
      handleLogin().then(
        (user) => {
          NotificationSnackbar()
              .success('Login Successful', 'Welcome ${user.firstName}'),
          Get.offAllNamed('/home')
        },
      );
    }
    isLoading.value = false;
  }

  Future<User> handleLogin() async {
    final response = await AuthRepository().login(email, password);
    ResponseSuccess result = ResponseSuccess.fromJson(response);
    User user = User.fromJson(result.data);
    storage.value.write('userToken', user.token ?? '');
    storage.value.write('userData', result.data);
    return user;
  }
}
