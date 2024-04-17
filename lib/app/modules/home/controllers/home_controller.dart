import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController
  RxBool isLoading = false.obs;
  final count = 0.obs;

  RxBool isflowBottomSheet = false.obs;
  RxBool isflowSwitchOn = false.obs;

  RxBool isSetDrip = false.obs;

  RxBool isHeaterSwitchOn = false.obs;
  RxBool isBlowerSwitchOn = false.obs;

  Rx<GetStorage> storage = GetStorage().obs;

  @override
  void onInit() {
    printInfo(info: storage.value.read('userToken'));
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

  //Draft pindah page?
  void createGreenhouse() {}

  void onFlowSwitch(bool confirmSwitchOn) {
    if (confirmSwitchOn) {
      // Toggle only if confirmed
      isflowSwitchOn.value = true;
    } else {
      // If 'No' is pressed, revert the switch to the previous state
      isflowSwitchOn.value = false;
    }
    Navigator.pop(Get.context!); // Close bottom sheet
  }

  void onBlowerSwitch(bool confirmSwitchOn) {
    if (confirmSwitchOn) {
      isBlowerSwitchOn.value = true;
    } else {
      isBlowerSwitchOn.value = false;
    }
  }

  void onHeaterSwitch(bool confirmSwitchOn) {
    if (confirmSwitchOn) {
      isHeaterSwitchOn.value = true;
    } else {
      isHeaterSwitchOn.value = false;
    }
  }

  void onSetDrip(bool confirmSet) {
    //Drip Irrigation Setting Function
    if (confirmSet) {
      isSetDrip.value = true;
    } else {
      isSetDrip.value = false;
    }
    Navigator.pop(Get.context!);
  }

  void onCreateGreenhouse(bool confirmSet) {
    //Create Greenhouse Function
    if (confirmSet) {
      isSetDrip.value = true;
    } else {
      isSetDrip.value = false;
    }
    Navigator.pop(Get.context!);
  }
}
