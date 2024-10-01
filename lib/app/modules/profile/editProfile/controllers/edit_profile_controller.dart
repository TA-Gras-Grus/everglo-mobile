import 'package:everglo_mobile/app/data/models/response.dart';
import 'package:everglo_mobile/app/data/models/user.dart';
import 'package:everglo_mobile/app/data/repository/auth_repository.dart';
import 'package:everglo_mobile/app/helpers/global_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProfileController extends GetxController {
  final GlobalController globalController = Get.find();
  final GlobalKey<FormBuilderState> editFormKey =
      GlobalKey<FormBuilderState>(debugLabel: 'editForm');
  Rx<GetStorage> storage = GetStorage().obs;
  RxBool isLoading = false.obs;
  RxString fullname = ''.obs;
  RxString email = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fullname.value =
        '${globalController.user.value.firstName} ${globalController.user.value.lastName}';
    email.value = '${globalController.user.value.email}';
  }

  validateEmail(String? email) {
    if (!GetUtils.isEmail(email ?? '')) {
      return 'Email is not valid';
    }
    return null;
  }

  validateFullname(String? fullname) {
    if (GetUtils.isNullOrBlank(fullname ?? '') == null) {
      return 'Fullname is not valid';
    }
    return null;
  }

  void handleSave() {
    if (!editFormKey.currentState!.validate()) {
      Get.snackbar(
        'Error',
        'Login Unsuccessful',
        snackPosition: SnackPosition.TOP,
        colorText: Colors.white,
        backgroundColor: Colors.red,
        margin: const EdgeInsets.fromLTRB(10, 30, 10, 0),
      );
    } else {
      try {
        isLoading.value = true;
        printInfo(info: isLoading.value.toString());
        updateProfile().then(
          (user) => {
            globalController.user.value = user,
            showModalBottomSheet<void>(
              isScrollControlled: true,
              context: Get.context!,
              builder: updatedProfileBottomSheet,
            )
          },
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<User> updateProfile() async {
    final response = await AuthRepository().updateProfile(fullname, email);
    ResponseSuccess result = ResponseSuccess.fromJson(response);
    User user = User.fromJson(result.data);
    storage.value.write('userData', result.data);
    return user;
  }

  Widget updatedProfileBottomSheet(BuildContext context) => Container(
        height: 402,
        width: 393,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30, bottom: 12),
                width: 132,
                height: 132,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset('assets/images/updated.png'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 22),
                child: Text(
                  'Profile Updated!',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35, right: 30, bottom: 24),
                child: Text(
                  'Your profile has been successfully updated, changes are reflected real time.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF838FA0),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () => {Get.back(), Get.back()},
                child: Container(
                  margin: const EdgeInsets.only(left: 14, right: 5),
                  height: 50,
                  width: 327,
                  decoration: BoxDecoration(
                    color: const Color(0xFF52B788),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      'Confirm',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget failedUpdateProfileBottomSheet(BuildContext context) => Container(
        height: 468,
        width: 393,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 30, bottom: 12),
                width: 132,
                height: 132,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset('assets/images/failed.png'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 5, bottom: 14),
                child: Text(
                  'Profile Update Failed',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35, right: 30, bottom: 18),
                child: Text(
                  'Oops, there are something wrong with updating details, please try again in a moment.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF838FA0),
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () => Navigator.pop(Get.context!),
                child: Container(
                  margin: const EdgeInsets.only(left: 14, right: 5),
                  height: 50,
                  width: 327,
                  decoration: BoxDecoration(
                    color: const Color(0xFF52B788),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: Text(
                      'Try Again',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              MaterialButton(
                onPressed: () => Navigator.pop(Get.context!),
                child: Container(
                  margin: const EdgeInsets.only(left: 14, right: 5),
                  height: 50,
                  width: 327,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(
                              0.2), // Adjust opacity for shadow intensity
                          blurRadius:
                              10.0, // Adjust blur radius for shadow softness
                          spreadRadius:
                              1.0, // Adjust spread radius for shadow size
                        ),
                      ]),
                  child: Center(
                    child: Text(
                      'Cancel',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF52B788),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
}
