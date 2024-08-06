import 'package:everglo_mobile/app/data/models/Response.dart';
import 'package:everglo_mobile/app/data/models/polybag.dart';
import 'package:everglo_mobile/app/data/repository/polybag_repositoy.dart';
import 'package:everglo_mobile/app/helpers/global_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class PolybagsListsController extends GetxController {
  final GlobalController globalController = Get.find();
  RxBool isLoading = false.obs;
  RxString polybagId = "".obs;
  RxString greenhouseId = "".obs;
  RxString dayOfPlanted = "".obs;
  RxString isActive = "".obs;
  RxString plantTypeId = "".obs;
  Rx<Paging> pagination =
      Paging.fromJson({'current_page': 1, 'total_page': 1, 'size': 10}).obs;
  RxList<Polybag> polybags = [
    Polybag.fromJson({'': ''})
  ].obs;

  @override
  void onInit() {
    plantTypeId.value = Get.arguments['typeId'];
    greenhouseId.value =
        globalController.selectedGreenhouse.value.greenhouseId ?? "";
    super.onInit();
    initializeDateFormatting();
    getPolybags();
  }

  Future<void> getPolybags() async {
    isLoading.value = true;
    final res = await PolybagRepository().getPolybags(
        polybagId.value,
        greenhouseId.value,
        dayOfPlanted.value,
        isActive.value,
        plantTypeId.value,
        pagination.value);
    ResponseSuccess response = ResponseSuccess.fromJson(res);
    Polybags result = Polybags.fromJson(response.data);
    polybags.value = result.polybag!.map((e) => e).toList();
    pagination.value = result.paging!;
    isLoading.value = false;
  }

  String toLocalDate(DateTime val) {
    String result = DateFormat.yMMMMEEEEd('id').format(val);
    return result;
  }
}
