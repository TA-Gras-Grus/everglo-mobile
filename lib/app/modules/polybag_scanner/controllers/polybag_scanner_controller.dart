import 'package:get/get.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class PolybagScannerController extends GetxController {
  //TODO: Implement PolybagScannerController
  RxBool isLoading = false.obs;
  final count = 0.obs;
  // final MobileScannerController mobileScannerController =
  //     MobileScannerController();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void onScanBarcode() async {
    // // Request camera permissions (if needed)
    // await MobileScanner.askCameraPermission(); // Updated permission request

    // // Configure camera (optional, based on your needs)
    // // mobileScannerController.setCamera(camera: Camera(向き: CameraLensDirection.back)); // Example for back camera

    // final barcode =
    //     await mobileScannerController.capture(); // Updated scan method

    // if (barcode != null) {
    //   // Handle the scanned barcode data
    //   print('Barcode Found! ${barcode.rawValue}');
    //   // You can also access other barcode properties like format
    //   // final barcodeFormat = barcode.format;
    // } else {
    //   // Handle the case where no barcode was found
    //   print('No barcode found');
    // }

    // // Stop the camera after scanning (optional)
    // await mobileScannerController.stop();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
}
