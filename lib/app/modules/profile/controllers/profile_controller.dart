import 'package:everglo_mobile/app/data/models/User.dart';
import 'package:everglo_mobile/app/helpers/global_controller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ProfileController extends GetxController {
  final GlobalController globalController = Get.find();
  RxBool isLoading = false.obs;
  Rx<GetStorage> storage = GetStorage().obs;

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

  void handleLogout() {
    storage.value.remove('userToken');
    storage.value.remove('userData');
    Get.offAllNamed('/login');
  }
}
