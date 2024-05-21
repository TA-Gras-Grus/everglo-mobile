import 'package:everglo_mobile/app/helpers/dio_interceptor.dart';
import 'package:get/get.dart';

class AuthRepository {
  login(RxString email, RxString password) async {
    final response = await ApiClient().post('/users/login',
        data: {'email': email.value, 'password': password.value},
        isAuth: false);
    return await response.data;
  }

  updateProfile(RxString fullname, RxString email) async {
    List<String> nameArray = fullname.split(' ');
    String firstName = nameArray[0];
    nameArray.removeAt(0);
    String lastName = '${nameArray.join(' ')}';
    printInfo(info: lastName);
    final response = await ApiClient().patch('/users/update-profile', data: {
      'email': email.value,
      'firstName': firstName,
      'lastName': lastName
    });
    return await response.data;
  }
}
