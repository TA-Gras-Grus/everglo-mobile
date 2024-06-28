import 'package:everglo_mobile/app/helpers/dio_interceptor.dart';

class ForgotPasswordRepository {
  sendEmail(String email) async {
    final response = await ApiClient()
        .post('/users/forgot-password', data: {'email': email});
    return await response.data;
  }

  sendOtp(String email, String otp) async {
    final response = await ApiClient().post('/users/verify-forgot-password',
        data: {'email': email, 'otp': otp});
    return await response.data;
  }

  resetPassword(String password, String passwordConfrim) async {
    final response = await ApiClient().patch('/users/reset-password', data: {
      'newPassword': password,
      'confirmPassword': passwordConfrim,
    });
    return await response.data;
  }
}
