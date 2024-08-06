import 'package:everglo_mobile/app/data/models/Response.dart';
import 'package:everglo_mobile/app/data/repository/auth_repository.dart';
import 'package:everglo_mobile/app/helpers/notification_snackbar.dart';
import 'package:everglo_mobile/app/helpers/ui_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class ChangePasswordProfileController extends GetxController {
  final GlobalKey<FormBuilderState> formKey = GlobalKey();
  Rx<FocusNode> focusNode = FocusNode().obs;
  Rx<FocusNode> focusNode2 = FocusNode().obs;
  Rx<FocusNode> focusNode3 = FocusNode().obs;
  RxBool isOldPasswordHidden = true.obs;
  RxBool isPasswordHidden = true.obs;
  RxBool isPasswordConfirmHidden = true.obs;
  Rx<Color> focusedIconColor = UiColor().primary.obs;
  Rx<Color> unfocusedIconColor = Colors.black45.obs;
  RxBool isLoading = false.obs;
  RxString oldPassword = ''.obs;
  RxString password = ''.obs;
  RxString passwordConfirm = ''.obs;

  String? validateOldPassword(String value) {
    RegExp regex = RegExp(r'.{8,}$');
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

  void onChangePassword() {
    if (!formKey.currentState!.validate()) {
      NotificationSnackbar()
          .error('Failed', 'Please fill the fields correctly');
    } else {
      isLoading.value = true;

      handleChangePassword().then((value) {
        NotificationSnackbar()
            .success('Success', 'Your password has been changed successfully');
        isLoading.value = false;
      }).onError((error, stackTrace) {
        isLoading.value = false;
        return null;
      });
    }
  }

  Future<ResponseSuccess> handleChangePassword() async {
    final response = await AuthRepository().changePassword(
        oldPassword.value, password.value, passwordConfirm.value);
    ResponseSuccess result = ResponseSuccess.fromJson(response);
    return result;
  }
}
