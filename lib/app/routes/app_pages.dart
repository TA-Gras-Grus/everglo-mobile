import 'package:get/get.dart';

import '../modules/forgetPassword/bindings/forget_password_binding.dart';
import '../modules/forgetPassword/views/change_password_view.dart';
import '../modules/forgot_password/reset_password/bindings/reset_password_binding.dart';
import '../modules/forgot_password/reset_password/views/reset_password_view.dart';
import '../modules/forgot_password/send_email/bindings/send_email_binding.dart';
import '../modules/forgot_password/send_email/views/send_email_view.dart';
import '../modules/forgot_password/send_otp/bindings/send_otp_binding.dart';
import '../modules/forgot_password/send_otp/views/send_otp_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/polybag_scanner/bindings/polybag_scanner_binding.dart';
import '../modules/polybag_scanner/views/polybag_scanner_view.dart';
import '../modules/polybags/polybagsDetail/bindings/polybags_detail_binding.dart';
import '../modules/polybags/polybagsDetail/views/polybags_detail_view.dart';
import '../modules/polybags/polybagsLists/bindings/polybagsLists_binding.dart';
import '../modules/polybags/polybagsLists/views/polybagsLists_view.dart';
import '../modules/polybags/polybagsPlants/bindings/polybagsPlants_binding.dart';
import '../modules/polybags/polybagsPlants/views/polybags_plants_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/change_password_profile/bindings/change_password_profile_binding.dart';
import '../modules/profile/change_password_profile/views/change_password_profile_view.dart';
import '../modules/profile/editProfile/bindings/edit_profile_binding.dart';
import '../modules/profile/editProfile/views/edit_profile_view.dart';
import '../modules/profile/profileDetail/bindings/profile_detail_binding.dart';
import '../modules/profile/profileDetail/views/profile_detail_view.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/splashScreen/bindings/splash_screen_binding.dart';
import '../modules/splashScreen/views/splash_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.FORGET_PASSWORD,
      page: () => ChangePasswordView(),
      binding: ForgetPasswordBinding(),
    ),
    GetPage(
      name: _Paths.POLYBAG_SCANNER,
      page: () => const PolybagScannerView(),
      binding: PolybagScannerBinding(),
    ),
    GetPage(
      name: _Paths.POLYBAGS,
      page: () => const PolybagsPlantsView(),
      binding: PolybagsPlantsBinding(),
      children: [
        GetPage(
          name: _Paths.POLYBAGS_LISTS,
          page: () => const PolybagsListsView(),
          binding: PolybagsListsBinding(),
        ),
        GetPage(
          name: _Paths.POLYBAGS_DETAIL,
          page: () => PolybagsDetailView(),
          binding: PolybagsDetailBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
      children: [
        GetPage(
          name: _Paths.PROFILE_DETAIL,
          page: () => ProfileDetailView(),
          binding: ProfileDetailBinding(),
        ),
        GetPage(
          name: _Paths.EDIT_PROFILE,
          page: () => EditProfileView(),
          binding: EditProfileBinding(),
        ),
        GetPage(
          name: _Paths.CHANGE_PASSWORD_PROFILE,
          page: () => ChangePasswordProfileView(),
          binding: ChangePasswordProfileBinding(),
        ),
      ],
    ),
    GetPage(
      name: _Paths.SEND_EMAIL,
      page: () => SendEmailView(),
      binding: SendEmailBinding(),
    ),
    GetPage(
      name: _Paths.SEND_OTP,
      page: () => const SendOtpView(),
      binding: SendOtpBinding(),
    ),
    GetPage(
      name: _Paths.RESET_PASSWORD,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
  ];
}
