import 'package:everglo_mobile/app/helpers/global_controller.dart';
import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
    Get.lazyPut<GlobalController>(
      () => GlobalController(),
    );
  }
}
