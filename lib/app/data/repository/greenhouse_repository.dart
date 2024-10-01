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
    final response = await ApiClient().patch(
        '/greenhouses/update-greenhouse?${id != "" ? 'deviceId=' : ''}$id',
        data: {
          'name': name,
          'statusBlower': blower,
          'statusHeater': heater,
          'timeWaterFlow': flowTime,
          'intervalWaterFlow': interval,
          'statusWaterFlow': flow
        });
    return await response.data;
  }

  connectDevice(
    String id,
    String waterTank,
    String dripIrrigation,
    String heaterBlower,
  ) async {
    Map<String, dynamic> data = {};
    if (waterTank != "") {
      data['waterTankDevice'] = waterTank;
    }
    if (dripIrrigation != "") {
      data['dripIrrigationDevice'] = dripIrrigation;
    }
    if (heaterBlower != "") {
      data['heaterBlowerDevice'] = heaterBlower;
    }
    final response = await ApiClient()
        .patch('/greenhouses/connect-device?greenhouseId=$id', data: data);
    return await response.data;
  }
}
