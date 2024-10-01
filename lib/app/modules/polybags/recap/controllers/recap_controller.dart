import 'package:everglo_mobile/app/data/models/Response.dart';
import 'package:everglo_mobile/app/data/models/plant_type.dart';
import 'package:everglo_mobile/app/data/repository/plant_type_repository.dart';
import 'package:everglo_mobile/app/helpers/notification_snackbar.dart';
import 'package:everglo_mobile/app/modules/home/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';

class RecapController extends GetxController {
  final HomeController homeController = Get.find<HomeController>();
  final GlobalKey<FormBuilderState> formKey = GlobalKey();
  RxBool isLoading = false.obs;
  Rx<String> dateRange =
      "".obs; // 2024-08-16 00:00:00.000 - 2024-09-12 00:00:00.000
  Rx<RecapList> recaps = RecapList.fromJson({"recap": []}).obs;
  RxBool isFirstTime = true.obs;

  @override
  void onInit() {
    super.onInit();
    isFirstTime.value = true;
    isLoading.value = true;
    getRecap()
        .then((value) => {
              isLoading.value = false,
            })
        .onError((error, stackTrace) => {
              NotificationSnackbar().error('Error', error.toString()),
              isLoading.value = false
            });
  }

  Future<void> getRecap() async {
    String startDateValue = "";
    String endDateValue = "";
    if (dateRange.value != "") {
      startDateValue = dateRange.value.split(" - ")[0];
      endDateValue = dateRange.value.split(" - ")[1];
    }
    final response = await PlantTypeRepository().getRecap(
      homeController.greenhouse.value.greenhouseId ?? "",
      startDateValue,
      endDateValue,
    );
    ResponseSuccess result = ResponseSuccess.fromJson(response);
    recaps.value = RecapList.fromJson(result.data);
  }
}
