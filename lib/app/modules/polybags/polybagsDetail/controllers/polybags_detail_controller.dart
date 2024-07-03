import 'package:everglo_mobile/app/data/models/Response.dart';
import 'package:everglo_mobile/app/data/models/polybag.dart';
import 'package:everglo_mobile/app/data/repository/polybag_repositoy.dart';
import 'package:everglo_mobile/app/helpers/notification_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class PolybagsDetailController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool onHarvest = false.obs;
  RxString polybagId = "".obs;
  RxString weight = "".obs;
  Rx<Polybag> polybag = Polybag.fromJson({'': ''}).obs;

  @override
  void onInit() {
    polybagId.value = Get.arguments['polybagId'];
    super.onInit();
    initializeDateFormatting();
    getPolybag();
  }

  Future<void> getPolybag() async {
    isLoading.value = true;
    final res = await PolybagRepository().getPolybag(polybagId.value);
    ResponseSuccess response = ResponseSuccess.fromJson(res);
    Polybags result = Polybags.fromJson(response.data);
    polybag.value = result.polybag![0];
    isLoading.value = false;
  }

  String toLocalDate(DateTime val) {
    String result = DateFormat.yMMMMEEEEd('id').format(val);
    return result;
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

  Future updatePolybag() async {
    final res =
        await PolybagRepository().updatePolybag(polybagId.value, weight.value);
    return res;
  }
}
