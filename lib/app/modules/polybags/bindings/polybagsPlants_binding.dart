import 'package:get/get.dart';

import '../controllers/polybagsPlants_controller.dart';

class PolybagsPlantsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PolybagsPlantsController>(
      () => PolybagsPlantsController(),
    );
  }
}
