import 'package:everglo_mobile/app/helpers/dio_interceptor.dart';

class GreenhouseRepository {
  getListGreenhouse() async {
    final response = await ApiClient().get(
      '/greenhouses/get-list-greenhouse',
    );
    return await response.data;
  }

  getGreenhouse(String id) async {
    final response = await ApiClient().get(
      '/greenhouses/get-all-greenhouse?greenhouseId=$id',
    );
    return await response.data;
  }

  updateGreenhouse(
    String id,
    String name,
    bool blower,
    bool heater,
    bool flow,
    int flowTime,
    int interval,
  ) async {
    final response = await ApiClient()
        .patch('/greenhouses/update-greenhouse?greenhouseId=$id', data: {
      'name': name,
      'statusBlower': blower,
      'statusHeater': heater,
      'timeWaterFlow': flowTime,
      'intervalWaterFlow': interval,
      'statusWaterFlow': flow
    });
    return await response.data;
  }
}
