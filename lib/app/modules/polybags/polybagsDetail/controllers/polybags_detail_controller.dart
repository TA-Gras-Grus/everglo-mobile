import 'package:everglo_mobile/app/data/models/Response.dart';
import 'package:everglo_mobile/app/data/models/polybag.dart';
import 'package:everglo_mobile/app/data/repository/polybag_repositoy.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class PolybagsDetailController extends GetxController {
  RxBool isLoading = false.obs;
  RxString polybagId = "".obs;
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
}
