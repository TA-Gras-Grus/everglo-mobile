import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  RxBool isLoading = false.obs;
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
