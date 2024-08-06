import 'package:everglo_mobile/app/helpers/dio_interceptor.dart';

class PlantTypeRepository {
  getListPlantType(String greenhouseId) async {
    final response = await ApiClient().get(
      '/polybags/get-plant-type?greenhouseId=$greenhouseId',
    );
    return await response.data;
  }

  getRecap(String greenhouseId, String? startDate, String? endDate) async {
    final response = await ApiClient().get(
      '/polybags/recap-polybag?greenhouseId=$greenhouseId&startDate=$startDate&endDate=$endDate',
    );
    return await response.data;
  }
}
