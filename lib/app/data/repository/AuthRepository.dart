import 'package:everglo_mobile/app/helpers/dio_interceptor.dart';
import 'package:get/get.dart';

class AuthRepository {
  login(RxString email, RxString password) async {
    final response = await ApiClient().post('/users/login',
        data: {'email': email.value, 'password': password.value},
        isAuth: false);
    return await response.data;
  }
}
