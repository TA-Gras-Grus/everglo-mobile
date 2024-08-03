import 'dart:ui';

import 'package:everglo_mobile/app/helpers/bottom_navbar.dart';
import 'package:everglo_mobile/app/helpers/global_controller.dart';
import 'package:everglo_mobile/app/helpers/ui_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  final GlobalController globalController = Get.find();
  ProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: Text('Loading...'),
          );
        } else {
          return SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.asset(
                      'assets/images/polybags.png',
                      height: 300,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                    ClipRRect(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Container(
                          height: 300,
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.0),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 65),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 165),
                                child: Text(
                                  'Profile',
                                  style: GoogleFonts.poppins(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Center(
                            child: Container(
                              height: 90,
                              width: 90,
                              margin: const EdgeInsets.symmetric(vertical: 20),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
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
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(100.0),
                                child: Image.network(
                                  'https://via.placeholder.com/100x100?text=${globalController.user.value.firstName![0].toUpperCase()}',
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              '${globalController.user.value.firstName} ${globalController.user.value.lastName}',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, left: 145),
                                child: Container(
                                  height: 30,
                                  width: 100,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    color: Colors.white,
                                  ),
                                  child: Stack(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10, left: 10),
                                        child: SvgPicture.asset(
                                            'assets/icons/profileIcon.svg'),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 10),
                                        child: Center(
                                          child: Text(
                                            '${globalController.user.value.role}',
                                            style: GoogleFonts.poppins(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                              color: Colors.black,
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                _profileNavigation(
                    'top',
                    Icon(
                      Icons.person_2_outlined,
                      color: UiColor().primary,
                    ),
                    const Color(0xFFD8F2EA),
                    'Profile',
                    () => Get.toNamed('/profile/profile-detail')),
                _profileNavigation(
                    'bottom',
                    Icon(
                      Icons.lock_outline_rounded,
                      color: UiColor().primary,
                    ),
                    const Color(0xFFD8F2EA),
                    'Change Password',
                    () => Get.toNamed('/profile/change-password-profile')),
                const SizedBox(height: 20),
                _profileNavigation(
                    'center',
                    Icon(
                      Icons.logout_outlined,
                      color: UiColor().danger,
                    ),
                    const Color(0xFFFDE1DB),
                    'Logout',
                    () => controller.handleLogout()),
              ],
            ),
          );
        }
      }),
      bottomNavigationBar: const BottomNavbar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const ScanButton(),
    );
  }

  Widget _profileNavigation(String type, Icon icon, Color scheme, String label,
      void Function()? onTap) {
    return Container(
      width: 361,
      height: 67,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(type != 'bottom' ? 12 : 0),
          topRight: Radius.circular(type != 'bottom' ? 12 : 0),
          bottomLeft: Radius.circular(type != 'top' ? 12 : 0),
          bottomRight: Radius.circular(type != 'top' ? 12 : 0),
        ),
        border: const Border(
            bottom: BorderSide(color: Color(0xFFF0F0FA), width: 1.5)),
        color: Colors.white,
      ),
      child: MaterialButton(
        onPressed: onTap,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(type != 'bottom' ? 12 : 0),
            topRight: Radius.circular(type != 'bottom' ? 12 : 0),
            bottomLeft: Radius.circular(type != 'top' ? 12 : 0),
            bottomRight: Radius.circular(type != 'top' ? 12 : 0),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 38,
                  width: 38,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: scheme,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: icon,
                  ),
                ),
                const SizedBox(width: 20),
                Text(
                  label,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const Icon(
              Icons.chevron_right,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
