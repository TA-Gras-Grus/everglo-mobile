import 'package:everglo_mobile/app/helpers/global_controller.dart';
import 'package:get/get.dart';

import '../controllers/profile_detail_controller.dart';

class ProfileDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProfileDetailController>(
      () => ProfileDetailController(),
    );
    Get.lazyPut<GlobalController>(
      () => GlobalController(),
    );
  }
}
