import 'package:get/get.dart';
import 'dart:async';

class SplashScreenController extends GetxController {
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    Timer(const Duration(seconds: 3), () {
      printInfo(info: 'oke');
      isLoading.value = false;
      Get.offAllNamed('/login');
    });
    super.onInit();
  }
}
