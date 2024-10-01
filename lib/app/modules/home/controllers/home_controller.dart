import 'dart:convert';

import 'package:everglo_mobile/app/data/models/Response.dart';
import 'package:everglo_mobile/app/data/models/greenhouse.dart';
import 'package:everglo_mobile/app/data/repository/greenhouse_repository.dart';
import 'package:everglo_mobile/app/helpers/global_controller.dart';
import 'package:everglo_mobile/app/helpers/notification_snackbar.dart';
import 'package:everglo_mobile/app/modules/home/controllers/mqtt_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mqtt_client/mqtt_client.dart';

class HomeController extends GetxController {
  final GlobalController globalController = Get.find();
  final MqttService mqttService = Get.put(MqttService());
  RxBool isLoading = true.obs;
  RxBool isflowBottomSheet = false.obs;
  RxBool isflowSwitchOn = false.obs;
  RxBool isSetDrip = false.obs;
  RxBool isHeaterSwitchOn = false.obs;
  RxBool isBlowerSwitchOn = false.obs;
  RxBool onDripUpdate = false.obs;
  RxBool onBlowerUpdate = false.obs;
  RxBool onHeaterUpdate = false.obs;
  RxBool onFlowUpdate = false.obs;
  RxString flowInterval = "".obs;
  RxString irrigationTime = "".obs;
  RxString heaterBlowerDevice = "".obs;
  RxString dripIrrigationDevice = "".obs;
  RxString waterTankDevice = "".obs;
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
        "statusWaterTank": false,
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
    mqttService.connect();
    mqttService.client?.onSubscribed = onSubscribed;
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

  @override
  void onClose() {
    super.onClose();
    mqttService.disconnect();
  }

  void onFlowSwitch() {
    onFlowUpdate.value = true;
    final bool status = greenhouse.value.statusWaterFlow! ? false : true;
    if (status) {
      updateGreenhouse("dripIrrigation", null, null, status, null, null)
          .then((value) => {
                NotificationSnackbar()
                    .success('Greenhouse updated', 'The blower is now on'),
                onFlowUpdate.value = false
              })
          .onError((error, stackTrace) => {onFlowUpdate.value = false});
    } else {
      updateGreenhouse("dripIrrigation", false, null, status, null, null)
          .then((value) => {
                NotificationSnackbar()
                    .success('Greenhouse updated', 'The blower is now off'),
                onFlowUpdate.value = false
              })
          .onError((error, stackTrace) => {onFlowUpdate.value = false});
    }
    Navigator.pop(Get.context!); // Close bottom sheet
  }

  void onBlowerSwitch(bool confirmSwitchOn) {
    onBlowerUpdate.value = true;
    if (confirmSwitchOn) {
      updateGreenhouse("heaterBlower", true, null, null, null, null)
          .then((value) => {
                NotificationSnackbar()
                    .success('Greenhouse updated', 'The blower is now on'),
                onBlowerUpdate.value = false
              })
          .onError((error, stackTrace) => {onBlowerUpdate.value = false});
    } else {
      updateGreenhouse("heaterBlower", false, null, null, null, null)
          .then((value) => {
                NotificationSnackbar()
                    .success('Greenhouse updated', 'The blower is now off'),
                onBlowerUpdate.value = false
              })
          .onError((error, stackTrace) => {onBlowerUpdate.value = false});
    }
  }

  void onHeaterSwitch(bool confirmSwitchOn) {
    onHeaterUpdate.value = true;
    if (confirmSwitchOn) {
      updateGreenhouse("heaterBlower", null, true, null, null, null)
          .then((value) => {
                NotificationSnackbar()
                    .success('Greenhouse updated', 'The heater is now on'),
                onHeaterUpdate.value = false
              })
          .onError((error, stackTrace) => {onHeaterUpdate.value = false});
    } else {
      updateGreenhouse("heaterBlower", null, false, null, null, null)
          .then((value) => {
                NotificationSnackbar()
                    .success('Greenhouse updated', 'The heater is now off'),
                onHeaterUpdate.value = false
              })
          .onError((error, stackTrace) => {onHeaterUpdate.value = false});
    }
  }

  void onSetDrip() {
    onDripUpdate.value = true;
    final interval = flowInterval.value.isNotEmpty
        ? flowInterval.value
        : greenhouse.value.intervalWaterFlow;
    final time = irrigationTime.value.isNotEmpty
        ? irrigationTime.value
        : greenhouse.value.timeWaterFlow;
    updateGreenhouse("dripIrrigation", null, null, null,
            int.parse(time.toString()), int.parse(interval.toString()))
        .then((value) => {
              Navigator.pop(Get.context!),
              onDripUpdate.value = false,
              showModalBottomSheet<void>(
                context: Get.context!,
                builder: _updatedSetDripBottomSheet,
              )
            })
        .onError((error, stackTrace) => {
              onDripUpdate.value = false,
              NotificationSnackbar()
                  .error('Failed', 'Drip irrigation failed to update')
            });
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

  void onConnectDevice() {
    connectDevice(
      waterTankDevice.value,
      dripIrrigationDevice.value,
      heaterBlowerDevice.value,
    )
        .then((value) => {
              NotificationSnackbar()
                  .success('Success', 'Devices connected successfully'),
              getGreenhouse().then(
                (value) => {
                  Navigator.pop(Get.context!),
                },
              ),
            })
        .onError((error, stackTrace) => {
              NotificationSnackbar()
                  .error('Failed', 'Failed to connect devices'),
            });
  }

  Future<ListGreenhouse> getGreenhouse() async {
    final response = await GreenhouseRepository().getGreenhouse(
        globalController.selectedGreenhouse.value.greenhouseId ?? "");
    ResponseSuccess result = ResponseSuccess.fromJson(response);
    ListGreenhouse listGreenhouse = ListGreenhouse.fromJson(result.data);
    greenhouse.value = listGreenhouse.greenhouse![0];
    heaterBlowerDevice.value = greenhouse.value.heaterBlowerDevice ?? "";
    dripIrrigationDevice.value = greenhouse.value.dripIrrigationDevice ?? "";
    waterTankDevice.value = greenhouse.value.waterTankDevice ?? "";
    return listGreenhouse;
  }

  Future<void> updateGreenhouse(
    String? type,
    bool? blower,
    bool? heater,
    bool? flow,
    int? flowTime,
    int? interval,
  ) async {
    final id = type == "dripIrrigation"
        ? greenhouse.value.dripIrrigationDevice
        : type == "heaterBlower"
            ? greenhouse.value.heaterBlowerDevice
            : greenhouse.value.waterTankDevice;
    final response = await GreenhouseRepository().updateGreenhouse(
      id ?? "",
      greenhouse.value.name ?? "",
      blower ?? greenhouse.value.statusBlower ?? true,
      heater ?? greenhouse.value.statusHeater ?? true,
      flow ?? greenhouse.value.statusWaterFlow ?? true,
      flowTime ?? greenhouse.value.timeWaterFlow ?? 0,
      interval ?? greenhouse.value.intervalWaterFlow ?? 0,
    );
    ResponseSuccess result = ResponseSuccess.fromJson(response);
    greenhouse.value = Greenhouse.fromJson(result.data);
  }

  Future<void> connectDevice(
    String waterTank,
    String dripIrrigation,
    String heaterBlower,
  ) async {
    final response = await GreenhouseRepository().connectDevice(
      greenhouse.value.greenhouseId ?? "",
      waterTank,
      dripIrrigation,
      heaterBlower,
    );
    return response;
  }

  void onSubscribed(String topic) {
    mqttService.client?.updates
        ?.listen((List<MqttReceivedMessage<MqttMessage>> event) {
      final MqttPublishMessage recMess = event[0].payload as MqttPublishMessage;
      final String message =
          MqttPublishPayload.bytesToStringAsString(recMess.payload.message);
      if (topic == 'greenhouse:updated') {
        Greenhouse fromMessage = Greenhouse.fromJson(jsonDecode(message));
        if (fromMessage.greenhouseId == greenhouse.value.greenhouseId) {
          greenhouse.value = fromMessage;
          printInfo(info: greenhouse.value.toJson().toString());
        }
      } else if (topic == 'greenhouseData:created') {
        GreenhouseData fromMessage =
            GreenhouseData.fromJson(jsonDecode(message));
        if (fromMessage.ownedGreenhouse == greenhouse.value.greenhouseId) {
          greenhouse.value.greenhouseDatas![0].airTemperature =
              fromMessage.airTemperature;
          greenhouse.value.greenhouseDatas![0].humidity = fromMessage.humidity;
          printError(
              info: greenhouse.value.greenhouseDatas![0].toJson().toString());
          greenhouse.refresh();
        }
      }
    });
  }

  Widget _updatedSetDripBottomSheet(BuildContext context) => Container(
        height: 398,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 40, bottom: 12),
                width: 132,
                height: 132,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset('assets/images/updated.png'),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 10, bottom: 12),
                child: Text(
                  'Drip Irrigation Updated',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 35, right: 30, bottom: 24),
                child: Text(
                  'Your drip irrigation setting  has been successfully updated, changes are reflected real time.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF838FA0),
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () => Navigator.pop(Get.context!),
                child: Container(
                  margin: const EdgeInsets.only(left: 14, right: 5),
                  height: 50,
                  width: 327,
                  decoration: BoxDecoration(
                    color: const Color(0xFF52B788),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Center(
                    child: Text(
                      'Confirm',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
