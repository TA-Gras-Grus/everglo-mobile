import 'package:everglo_mobile/app/modules/forgetPassword/controllers/forget_password_controller.dart';
import 'package:everglo_mobile/app/modules/home/views/component/bottom_navigation_view.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(HomeController());
    Get.put(ForgetPasswordController());
    Get.put(const BottomNavigationView()); // Register the view here
  }
}
