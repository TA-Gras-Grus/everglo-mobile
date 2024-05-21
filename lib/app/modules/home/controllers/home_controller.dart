import 'package:everglo_mobile/app/data/models/Response.dart';
import 'package:everglo_mobile/app/data/models/greenhouse.dart';
import 'package:everglo_mobile/app/data/repository/greenhouse_repository.dart';
import 'package:everglo_mobile/app/helpers/global_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HomeController extends GetxController {
  final GlobalController globalController = Get.find();
  RxBool isLoading = false.obs;
  RxBool isflowBottomSheet = false.obs;
  RxBool isflowSwitchOn = false.obs;
  RxBool isSetDrip = false.obs;
  RxBool isHeaterSwitchOn = false.obs;
  RxBool isBlowerSwitchOn = false.obs;
  Rx<GetStorage> storage = GetStorage().obs;
  Rx<ListGreenhouseSum> listGreenhouse = ListGreenhouseSum.fromJson({
    "greenhouse": [
      {"greenhouseId": "", "owned": "", "name": ""},
    ]
  }).obs;
  Rx<Greenhouse> greenhouse = Greenhouse.fromJson({
    "greenhouseId": "",
    "owned": "",
    "name": "",
    "statusWaterFlow": false,
    "statusBlower": false,
    "statusHeater": false,
    "intervalWaterFlow": 0,
    "timeWaterFlow": 0,
    "createdAt": "2024-04-22T07:39:28.616Z",
    "updatedAt": "2024-04-22T07:39:28.616Z",
    "greenhouse_datas": [
      {
        "greenhouseDataId": "",
        "ownedGreenhouse": "",
        "airTemperature": 0,
        "humidity": 0,
        "ec": 0,
        "ph": 0,
        "ppm": 0,
        "volumeWaterTank": 0,
        "countWaterFlow": 8,
        "createdAt": "2024-04-22T07:39:28.616Z",
        "updatedAt": "2024-04-22T07:39:28.616Z",
      },
    ],
  }).obs;

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    globalController.getListGreenhouse().then(
          (value) => {
            listGreenhouse.value = value,
            if (value.greenhouse!.isNotEmpty)
              {
                if (storage.value.read('selectedGreenhouse') != null)
                  {
                    if (storage.value.read('selectedGreenhouse')
                        is GreenhouseSum)
                      {
                        globalController.selectedGreenhouse.value =
                            storage.value.read('selectedGreenhouse')
                      }
                    else
                      {
                        globalController.selectedGreenhouse.value =
                            GreenhouseSum.fromJson(
                                storage.value.read('selectedGreenhouse'))
                      }
                  }
                else
                  {
                    globalController.selectedGreenhouse.value =
                        value.greenhouse![0],
                    storage.value.write(
                      'selectedGreenhouse',
                      value.greenhouse![0],
                    )
                  }
              },
            getGreenhouse().then(
              (value) => {isLoading.value = false},
            ),
          },
        );
  }

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

  void handleDropdownGreenhouse(greenhouseId) {
    isLoading.value = true;
    GreenhouseSum selected = listGreenhouse.value.greenhouse!
        .where((greenhouse) => greenhouse.greenhouseId == greenhouseId)
        .toList()[0];
    globalController.selectedGreenhouse.value = selected;
    storage.value.write(
      'selectedGreenhouse',
      selected,
    );
    getGreenhouse().then((value) => isLoading.value = false);
  }

  Future<ListGreenhouse> getGreenhouse() async {
    final response = await GreenhouseRepository().getGreenhouse(
        globalController.selectedGreenhouse.value.greenhouseId ?? "");
    ResponseSuccess result = ResponseSuccess.fromJson(response);
    ListGreenhouse listGreenhouse = ListGreenhouse.fromJson(result.data);
    greenhouse.value = listGreenhouse.greenhouse![0];
    return listGreenhouse;
  }
}
