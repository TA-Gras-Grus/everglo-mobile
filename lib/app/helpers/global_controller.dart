import 'package:everglo_mobile/app/data/models/Response.dart';
import 'package:everglo_mobile/app/data/models/greenhouse.dart';
import 'package:everglo_mobile/app/data/models/user.dart';
import 'package:everglo_mobile/app/data/repository/greenhouse_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class GlobalController extends GetxController {
  RxBool isLoading = true.obs;
  Rx<GetStorage> storage = GetStorage().obs;
  Rx<User> user = User.fromJson({
    "userId": "",
    "email": "",
    "firstName": "",
    "lastName": "",
    "role": "",
    "image": null,
    "owned": "",
    "createdAt": "2024-05-14T07:52:17.704Z",
    "updatedAt": "2024-05-14T07:52:17.704Z"
  }).obs;

  Rx<GreenhouseSum> selectedGreenhouse = GreenhouseSum.fromJson(
    {"greenhouseId": "", "owned": "", "name": ""},
  ).obs;

  @override
  void onInit() {
    super.onInit();
    user.value = User.fromJson(storage.value.read('userData'));
    if (storage.value.read('selectedGreenhouse') != null) {
      if (storage.value.read('selectedGreenhouse') is GreenhouseSum) {
        selectedGreenhouse.value = storage.value.read('selectedGreenhouse');
      } else {
        selectedGreenhouse.value =
            GreenhouseSum.fromJson(storage.value.read('selectedGreenhouse'));
      }
    }
  }

  Future<ListGreenhouseSum> getListGreenhouse() async {
    final response = await GreenhouseRepository().getListGreenhouse();
    ResponseSuccess result = ResponseSuccess.fromJson(response);
    ListGreenhouseSum listGreenhouse = ListGreenhouseSum.fromJson(result.data);
    return listGreenhouse;
  }
}
