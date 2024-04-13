import 'package:get/get.dart';

import '../controllers/polybag_scanner_controller.dart';

class PolybagScannerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PolybagScannerController>(
      () => PolybagScannerController(),
    );
  }
}
