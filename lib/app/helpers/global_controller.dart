import 'package:everglo_mobile/app/data/models/User.dart';
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

  @override
  void onInit() {
    super.onInit();
    user.value = User.fromJson(storage.value.read('userData'));
  }
}
