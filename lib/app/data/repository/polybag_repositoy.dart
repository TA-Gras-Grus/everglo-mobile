import 'package:everglo_mobile/app/data/models/Response.dart';
import 'package:everglo_mobile/app/helpers/dio_interceptor.dart';

class PolybagRepository {
  getPolybags(String polybagId, String greenhouseId, String dayOfPlanted,
      String isActive, String plantTypeId, Paging paging) async {
    final response = await ApiClient().get(
      '/polybags/get-all-polybag?page=${paging.currentPage}&size=${paging.size}&polybagId=${polybagId}&greenhouseId=${greenhouseId}&dayOfPlanted=&isActive=&plantTypeId=$plantTypeId',
    );
    return await response.data;
  }

  getPolybag(String polybagId) async {
    final response = await ApiClient()
        .get('/polybags/get-all-polybag?page=1&size=1&polybagId=$polybagId');
    return await response.data;
  }
}
