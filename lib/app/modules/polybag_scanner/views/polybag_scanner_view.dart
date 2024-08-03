import 'package:everglo_mobile/app/helpers/notification_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import '../controllers/polybag_scanner_controller.dart';

class PolybagScannerView extends GetView<PolybagScannerController> {
  const PolybagScannerView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        backgroundColor: const Color(0xFFF6F6F6),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(Get.context!),
          ),
        ),
        title: Text('Polybag Scanner',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            )),
        centerTitle: true,
      ),
      body: Center(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: Text('Loading..'),
            );
          } else {
            return Stack(
              children: [
                MobileScanner(
                  controller: MobileScannerController(
                      detectionSpeed: DetectionSpeed.noDuplicates,
                      autoStart: true),
                  onDetect: (capture) {
                    final List<Barcode> barcodes = capture.barcodes;
                    NotificationSnackbar().success(
                        'Polybag successfully scanned',
                        '${barcodes[0].rawValue}');
                    Get.toNamed('/polybags/polybags-detail',
                        arguments: {'polybagId': '${barcodes[0].rawValue}'});
                  },
                ),
                Positioned(
                  bottom: 55,
                  right: 140,
                  child: MaterialButton(
                    onPressed: () => controller.onScanBarcode(),
                    child: Container(
                      height: 80,
                      width: 80,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF00AD7C),
                        borderRadius: BorderRadius.circular(40),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF00AD7C).withOpacity(0.3),
                            spreadRadius: 10,
                            blurRadius: 28,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        height: 70.0,
                        width: 70.0,
                        decoration: BoxDecoration(
                          color: const Color(0xFF00AD7C),
                          borderRadius: BorderRadius.circular(40),
                          border: Border.all(
                              color: Colors.white.withOpacity(0.5), width: 3),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF00AD7C).withOpacity(0.3),
                              spreadRadius: 10,
                              blurRadius: 28,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: SvgPicture.asset(
                          'assets/icons/scan.svg',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
            // return MobileScanner(onDetect: (capture) {
            //   final List<Barcode> barcodes = capture.barcodes;
            //   for (final barcode in barcodes) {
            //     print(barcode.rawValue ?? "No Data found in QR");
            //   }
            // });
          }
        }),
      ),
    );
  }
}
