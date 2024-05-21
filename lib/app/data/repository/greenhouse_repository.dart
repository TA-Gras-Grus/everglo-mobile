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
}
