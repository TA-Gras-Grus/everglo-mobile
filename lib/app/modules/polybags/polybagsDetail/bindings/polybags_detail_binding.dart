import 'package:get/get.dart';

import '../controllers/polybags_detail_controller.dart';

class PolybagsDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PolybagsDetailController>(
      () => PolybagsDetailController(),
    );
  }
}
