import 'package:get/get.dart';
import 'dart:async';

import 'package:get_storage/get_storage.dart';

class SplashScreenController extends GetxController {
  RxBool isLoading = true.obs;
  Rx<GetStorage> storage = GetStorage().obs;

  @override
  void onInit() {
    Timer(const Duration(seconds: 3), () {
      printInfo(info: 'oke');
      isLoading.value = false;
      if (storage.value.read('userToken') != null &&
          storage.value.read('userToken') != '') {
        Get.offAllNamed('home');
      } else {
        Get.offAllNamed('/login');
      }
    });
    super.onInit();
  }
}
