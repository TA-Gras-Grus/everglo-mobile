import 'package:everglo_mobile/app/data/models/Response.dart';
import 'package:everglo_mobile/app/data/models/plant_type.dart';
import 'package:everglo_mobile/app/data/repository/plant_type_repository.dart';
import 'package:everglo_mobile/app/helpers/global_controller.dart';
import 'package:get/get.dart';

class PolybagsPlantsController extends GetxController {
  final GlobalController globalController = Get.find();
  RxBool isLoading = false.obs;
  Rx<ListPlantType> plantTypes = ListPlantType.fromJson({"planType": []}).obs;

  @override
  void onInit() {
    super.onInit();
    isLoading.value = true;
    getPlantType()
        .then((value) => {plantTypes.value = value, isLoading.value = false});
  }

  Future<ListPlantType> getPlantType() async {
    final response = await PlantTypeRepository().getListPlantType(
        globalController.selectedGreenhouse.value.greenhouseId ?? "");
    ResponseSuccess result = ResponseSuccess.fromJson(response);
    ListPlantType listPlantType = ListPlantType.fromJson(result.data);
    return listPlantType;
  }
}
