import 'package:everglo_mobile/app/data/models/Response.dart';
import 'package:everglo_mobile/app/helpers/dio_interceptor.dart';

class PolybagRepository {
  getPolybags(String polybagId, String greenhouseId, String dayOfPlanted,
      String isActive, String plantTypeId, Paging paging) async {
    final response = await ApiClient().get(
      '/polybags/get-all-polybag?page=${paging.currentPage}&size=${paging.size}&polybagId=$polybagId&greenhouseId=$greenhouseId&dayOfPlanted=&isActive=&plantTypeId=$plantTypeId',
    );
    return await response.data;
  }

  getPolybag(String polybagId) async {
    final response = await ApiClient()
        .get('/polybags/get-all-polybag?page=1&size=1&polybagId=$polybagId');
    return await response.data;
  }

  updatePolybag(String polybagId, String weight) async {
    final response = await ApiClient().patch(
        '/polybags/update-polybag?polybagId=$polybagId',
        data: {'isActive': false, 'weightOfHarvest': weight});
    return await response.data;
  }

  createPolybagData(
      String greenhouseId, String polybagId, double ec, double ph) async {
    final response = await ApiClient().post(
        '/polybags/create-polybag-data?apiKey=$greenhouseId&polybagId=$polybagId',
        data: {'ec': ec, 'ph': ph});
    return await response.data;
  }

  getAiPrediction(String greenhouseId, int aiCount) async {
    final response = await ApiClient().get(
        '/greenhouses/get-ai-prediction?greenhouseId=$greenhouseId&day=$aiCount');
    return await response.data;
  }
}
