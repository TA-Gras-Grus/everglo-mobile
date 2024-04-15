import 'package:get/get.dart';

import '../controllers/polybagsLists_controller.dart';

class PolybagsListsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PolybagsListsController>(
      () => PolybagsListsController(),
    );
  }
}
