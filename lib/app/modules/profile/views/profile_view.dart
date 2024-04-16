import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);
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
                      padding: EdgeInsets.only(top: 65),
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
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 150, top: 20),
                                child: Container(
                                  height: 90,
                                  width: 90,
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
                                    borderRadius: BorderRadius.circular(60),
                                    child: Image.asset(
                                      'assets/images/profileAdiat.jpeg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(top: 10, left: 120),
                                child: Text(
                                  'Adiat Rahman',
                                  style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            ],
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
                                            'User',
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
                SizedBox(height: 30),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 361,
                    height: 67,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      border: Border(
                          bottom:
                              BorderSide(color: Color(0xFFF0F0FA), width: 1.5)),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 15),
                        Container(
                          height: 38,
                          width: 38,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFFD8F2EA),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              'assets/icons/profileIcon.svg',
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          'Profile Detail',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 175),
                        SvgPicture.asset(
                          'assets/icons/rightArrow.svg',
                          color: Color(0xFFCFCFD6),
                          height: 12,
                          width: 12,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 0),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 361,
                    height: 67,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 15),
                        Container(
                          height: 38,
                          width: 38,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFFD8F2EA),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: SvgPicture.asset(
                              'assets/icons/password.svg',
                              color: Color(0xFF52B788),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          'Change Password',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 140),
                        SvgPicture.asset(
                          'assets/icons/rightArrow.svg',
                          color: Color(0xFFCFCFD6),
                          height: 12,
                          width: 12,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 361,
                    height: 67,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                      border: Border(
                          bottom:
                              BorderSide(color: Color(0xFFF0F0FA), width: 1.5)),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 15),
                        Container(
                          height: 38,
                          width: 38,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFFFDE1DB),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: SvgPicture.asset(
                              'assets/icons/logout.svg',
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          'Logout',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 210),
                        SvgPicture.asset(
                          'assets/icons/rightArrow.svg',
                          color: Color(0xFFCFCFD6),
                          height: 12,
                          width: 12,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 0),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 361,
                    height: 67,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(12),
                        bottomRight: Radius.circular(12),
                      ),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
                        SizedBox(width: 15),
                        Container(
                          height: 38,
                          width: 38,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Color(0xFFE8DAFC),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(9.0),
                            child: SvgPicture.asset(
                              'assets/icons/help.svg',
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Text(
                          'Help',
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(width: 225),
                        SvgPicture.asset(
                          'assets/icons/rightArrow.svg',
                          color: Color(0xFFCFCFD6),
                          height: 12,
                          width: 12,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
