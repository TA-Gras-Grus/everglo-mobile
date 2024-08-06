import 'package:everglo_mobile/app/data/models/Response.dart';
import 'package:everglo_mobile/app/data/models/polybag.dart';
import 'package:everglo_mobile/app/data/repository/polybag_repositoy.dart';
import 'package:everglo_mobile/app/helpers/global_controller.dart';
import 'package:everglo_mobile/app/helpers/notification_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'dart:math';

class PolybagsDetailController extends GetxController {
  final GlobalController globalController = Get.find();
  RxBool isLoading = false.obs;
  RxBool onHarvest = false.obs;
  RxString polybagId = "".obs;
  RxString weight = "".obs;
  RxString ec = "".obs;
  RxString ph = "".obs;
  Rx<Polybag> polybag = Polybag.fromJson({'': ''}).obs;
  Rx<AiPrediction> aiPredictions =
      AiPrediction.fromJson({'aiPrediction': []}).obs;

  @override
  void onInit() {
    polybagId.value = Get.arguments['polybagId'];
    super.onInit();
    initializeDateFormatting();
    getPolybag();
  }

  String toLocalDate(DateTime val) {
    String result = DateFormat('EEEE,\nd MMMM yyyy', 'id')
        .format(val); // Selasa, 20 Juli 2021

    return result;
  }

  getReversedData() {
    return polybag.value.polybagDatas!.reversed.toList();
  }

  getReversedAiData() {
    return aiPredictions.value.aiPrediction!.reversed.toList();
  }

  int getMaxY() {
    double valAi = 0;
    double valData = 0;
    if (aiPredictions.value.aiPrediction!.isNotEmpty) {
      valAi = aiPredictions.value.aiPrediction!
          .map((data) => data.ec!)
          .reduce((a, b) => max(a, b));
    } else {
      valAi = 0;
    }

    if (polybag.value.polybagDatas!.isNotEmpty) {
      valData = polybag.value.polybagDatas!
          .map((data) => data.ec!)
          .reduce((a, b) => max(a, b));
    } else {
      valData = 0;
    }

    int maxY = max(valAi.toInt(), valData.toInt()) + 5;
    return maxY;
  }

  onSaveHarvest() {
    onHarvest.value = true;
    if (weight.value.isNotEmpty) {
      Navigator.pop(Get.context!);
      updatePolybag()
          .then((value) => {
                NotificationSnackbar().success(
                    'Success', 'The plant has been successfully harvested'),
                getPolybag(),
                onHarvest.value = false
              })
          .onError((error, stackTrace) => {
                NotificationSnackbar()
                    .error('Failed', 'The plant failed to be harvested'),
                onHarvest.value = false
              });
    } else {
      NotificationSnackbar().error('Failed', 'Please fill the harvest weight');
      onHarvest.value = false;
    }
  }

  onCreateData() {
    if (ec.value.isNotEmpty && ph.value.isNotEmpty) {
      Navigator.pop(Get.context!);
      createPolybagData()
          .then((value) => {
                NotificationSnackbar().success('Success',
                    'New polybag data has been successfully created'),
                getPolybag(),
              })
          .onError((error, stackTrace) => {
                NotificationSnackbar()
                    .error('Failed', 'New polybag data failed to be created'),
              });
    } else {
      NotificationSnackbar().error('Failed', 'Please fill the field correctly');
    }
  }

  Future<void> getPolybag() async {
    isLoading.value = true;
    final res = await PolybagRepository().getPolybag(polybagId.value);
    ResponseSuccess response = ResponseSuccess.fromJson(res);
    Polybags result = Polybags.fromJson(response.data);
    polybag.value = result.polybag![0];
    final aiCount = polybag.value.polybagDatas!.isNotEmpty
        ? (polybag.value.polybagDatas![0].dayAfterPlanted! + 1)
        : 1;
    getAiPrediction(aiCount);
    isLoading.value = false;
  }

  Future<void> getAiPrediction(int aiCount) async {
    final res = await PolybagRepository().getAiPrediction(
        globalController.selectedGreenhouse.value.greenhouseId ?? "", aiCount);
    ResponseSuccess response = ResponseSuccess.fromJson(res);
    AiPrediction result = AiPrediction.fromJson(response.data);
    aiPredictions.value = result;
  }

  Future updatePolybag() async {
    final res =
        await PolybagRepository().updatePolybag(polybagId.value, weight.value);
    return res;
  }

  Future createPolybagData() async {
    final res = await PolybagRepository().createPolybagData(
        globalController.selectedGreenhouse.value.greenhouseId!,
        polybagId.value,
        double.parse(ec.value),
        double.parse(ph.value));
    return res;
  }
}
