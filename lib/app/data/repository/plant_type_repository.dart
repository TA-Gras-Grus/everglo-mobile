import 'package:everglo_mobile/app/helpers/dio_interceptor.dart';

class PlantTypeRepository {
  getListPlantType(String greenhouseId) async {
    final response = await ApiClient().get(
      '/polybags/get-plant-type?greenhouseId=$greenhouseId',
    );
    return await response.data;
  }
}
