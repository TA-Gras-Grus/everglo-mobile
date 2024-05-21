import 'package:everglo_mobile/app/data/models/greenhouse.dart';
import 'package:everglo_mobile/app/helpers/bottom_navbar.dart';
import 'package:everglo_mobile/app/helpers/global_controller.dart';
import 'package:everglo_mobile/app/helpers/ui_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  final GlobalController globalController = Get.find();
  HomeView({super.key});

  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return Center(
              child: SpinKitFoldingCube(
                color: UiColor().primary,
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  _userInfo(),
                  _greenhouseOption(context),
                  _plantsButton(),
                  _greenHouseStatistic(),
                  _greenHouseController(),
                  _waterTankStatistic(),
                  _dripIrrigationControl(context),
                  const SizedBox(
                    height: 50,
                  )
                ],
              ),
            );
          }
        },
      ),
      bottomNavigationBar: const BottomNavbar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: ScanButton(),
    );
  }

  Widget _userInfo() => Padding(
        padding:
            const EdgeInsets.only(left: 24, right: 24, top: 65, bottom: 22),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            //Left Side
            Row(
              children: [
                //Avatar
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(60 / 2),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(60 / 2),
                    child: Image.asset(
                      'assets/images/bagas.jpg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                //Info
                Padding(
                  // Add padding here
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Welcome!",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                          color: const Color(0xFF000000),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        globalController.user.value.firstName ?? '',
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: const Color(0xFF000000),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            IconButton(
                onPressed: () {},
                icon: SvgPicture.asset('assets/icons/notificationGreen.svg'))
          ],
        ),
      );

  Widget _greenhouseOption(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Row(
          //Select Greenhouse Button
          children: [
            DropdownButtonHideUnderline(
                child: Expanded(
              child: Container(
                height: 56,
                padding: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(width: 1.0, color: Colors.transparent),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(
                          0.2), // Adjust opacity for shadow intensity
                      blurRadius: 5.0, // Adjust blur radius for shadow softness
                      spreadRadius: 2.0, // Adjust spread radius for shadow size
                    ),
                  ],
                ),
                child: DropdownButton2<String>(
                  value: globalController.selectedGreenhouse.value.greenhouseId,
                  items: controller.listGreenhouse.value.greenhouse?[0]
                              .greenhouseId ==
                          ""
                      ? [
                          DropdownMenuItem(
                            value: globalController
                                .selectedGreenhouse.value.greenhouseId,
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                    'assets/icons/greenhouseIcon.svg'),
                                const SizedBox(width: 15),
                                Text(globalController
                                        .selectedGreenhouse.value.name ??
                                    ''),
                              ],
                            ),
                          ),
                        ]
                      : controller.listGreenhouse.value.greenhouse!
                          .map(
                            (e) => DropdownMenuItem(
                              value: e.greenhouseId,
                              child: Row(
                                children: [
                                  SvgPicture.asset(
                                      'assets/icons/greenhouseIcon.svg'),
                                  const SizedBox(width: 15),
                                  Text(e.name ?? ''),
                                ],
                              ),
                            ),
                          )
                          .toList(),
                  onChanged: (String? greenhouseId) {
                    controller.handleDropdownGreenhouse(greenhouseId);
                  },
                  dropdownStyleData: DropdownStyleData(
                    width: 260,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.white,
                    ),
                    offset: const Offset(-18, -16),
                  ),
                  iconStyleData: IconStyleData(
                    icon: SvgPicture.asset('assets/icons/dropdownIcon.svg'),
                    iconSize: 6,
                    openMenuIcon: SvgPicture.asset('assets/icons/arrowUp.svg'),
                  ),
                ),
              ),
            )),
          ],
        ),
      );

  Widget _plantsButton() => Padding(
        padding: const EdgeInsets.only(top: 16, left: 24, bottom: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            MaterialButton(
              onPressed: () => {},
              color: const Color(
                  0xFF00AD7C), // Set button color here for better readability
              padding: const EdgeInsets.only(left: 14, right: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment
                      .spaceBetween, // Aligns content horizontally
                  children: [
                    SvgPicture.asset(
                      'assets/icons/plantsIcon.svg',
                    ),
                    const SizedBox(width: 13),
                    Text(
                      "Your Plants",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 150),
                    SvgPicture.asset(
                      'assets/icons/rightArrow.svg',
                      color: Colors.white,
                    ),
                    // Add an empty container here if you want equal spacing between icon and text
                    Container(
                      width: 5,
                      height: 56,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(
                                0.2), // Adjust opacity for shadow intensity
                            blurRadius:
                                5.0, // Adjust blur radius for shadow softness
                            spreadRadius:
                                2.0, // Adjust spread radius for shadow size
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  Widget _greenHouseStatistic() => Padding(
        padding: const EdgeInsets.only(left: 24),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Statistics",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  width: 163,
                  height: 66,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(
                            0.2), // Adjust opacity for shadow intensity
                        blurRadius:
                            5.0, // Adjust blur radius for shadow softness
                        spreadRadius:
                            2.0, // Adjust spread radius for shadow size
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                            height: 50,
                            width: 51,
                            padding: const EdgeInsets.all(11),
                            color: const Color(0xFFFDF1E2),
                            child: SvgPicture.asset(
                                'assets/icons/totalPolybagIcon.svg')),
                      ),
                      const SizedBox(width: 13),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            '300',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Total Polybags',
                            style: GoogleFonts.poppins(
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 163,
                  height: 66,
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(
                            0.2), // Adjust opacity for shadow intensity
                        blurRadius:
                            5.0, // Adjust blur radius for shadow softness
                        spreadRadius:
                            2.0, // Adjust spread radius for shadow size
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                            height: 50,
                            width: 51,
                            padding: const EdgeInsets.all(11),
                            color: const Color(0xFFE5F7ED),
                            child: SvgPicture.asset(
                                'assets/icons/activePolybagIcon.svg')),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            '150',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Active Polybags',
                            style: GoogleFonts.poppins(
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  width: 163,
                  height: 66,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(
                            0.2), // Adjust opacity for shadow intensity
                        blurRadius:
                            5.0, // Adjust blur radius for shadow softness
                        spreadRadius:
                            2.0, // Adjust spread radius for shadow size
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                            height: 50,
                            width: 51,
                            padding: const EdgeInsets.all(11),
                            color: const Color(0xFFFBE1EC),
                            child: SvgPicture.asset(
                                'assets/icons/airTemperatureIcon.svg')),
                      ),
                      const SizedBox(width: 13),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            '${controller.greenhouse.value.greenhouseDatas?[0].airTemperature?.toStringAsFixed(2)}° C',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Air Temperature',
                            style: GoogleFonts.poppins(
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 163,
                  height: 66,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(
                            0.2), // Adjust opacity for shadow intensity
                        blurRadius:
                            5.0, // Adjust blur radius for shadow softness
                        spreadRadius:
                            2.0, // Adjust spread radius for shadow size
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                            height: 50,
                            width: 51,
                            padding: const EdgeInsets.all(11),
                            color: const Color(0xFFFDF1E2),
                            child: SvgPicture.asset(
                                'assets/icons/humidityIcon.svg')),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            '${controller.greenhouse.value.greenhouseDatas?[0].humidity?.toStringAsFixed(2)}% RH',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Humidity',
                            style: GoogleFonts.poppins(
                              fontSize: 9,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      );

  Widget _greenHouseController() => Padding(
        padding: const EdgeInsets.only(left: 24, bottom: 16),
        child: Row(children: [
          Container(
            width: 163,
            height: 90,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey
                      .withOpacity(0.2), // Adjust opacity for shadow intensity
                  blurRadius: 5.0, // Adjust blur radius for shadow softness
                  spreadRadius: 2.0, // Adjust spread radius for shadow size
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFB7E4C7),
                              Color(0xFFFFFFFF),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          height: 40,
                          width: 40,
                          child: SvgPicture.asset(
                              'assets/icons/blowerControl.svg'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: 54,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Switch.adaptive(
                          value: controller.isBlowerSwitchOn.value,
                          onChanged: (bool value) {
                            controller.isBlowerSwitchOn.value = value;
                            if (value) {
                              controller.isBlowerSwitchOn.value = true;
                            } else {
                              controller.isBlowerSwitchOn.value = value;
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                Row(
                  children: [
                    Text(
                      " Blower Control",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 163,
            height: 90,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey
                      .withOpacity(0.2), // Adjust opacity for shadow intensity
                  blurRadius: 5.0, // Adjust blur radius for shadow softness
                  spreadRadius: 2.0, // Adjust spread radius for shadow size
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFFB7E4C7),
                              Color(0xFFFFFFFF),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          height: 40,
                          width: 40,
                          child: SvgPicture.asset(
                              'assets/icons/heaterControl.svg'),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      width: 54,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        child: Switch.adaptive(
                          value: controller.isHeaterSwitchOn.value,
                          onChanged: (bool value) {
                            controller.isHeaterSwitchOn.value = value;
                            if (value) {
                              controller.isHeaterSwitchOn.value = true;
                            } else {
                              controller.isHeaterSwitchOn.value = value;
                            }
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 7),
                Row(
                  children: [
                    Text(
                      " Heater Control",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ]),
      );

  Widget _waterTankStatistic() => Padding(
        padding: const EdgeInsets.only(left: 24, bottom: 16),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  "Water Tank",
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  width: 163,
                  height: 66,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(
                            0.2), // Adjust opacity for shadow intensity
                        blurRadius:
                            5.0, // Adjust blur radius for shadow softness
                        spreadRadius:
                            2.0, // Adjust spread radius for shadow size
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                            height: 50,
                            width: 51,
                            padding: const EdgeInsets.all(11),
                            color: const Color(0xFFE4F8FB),
                            child: SvgPicture.asset(
                                'assets/icons/waterTankVolume.svg')),
                      ),
                      const SizedBox(width: 9),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            '${controller.greenhouse.value.greenhouseDatas?[0].volumeWaterTank?.toStringAsFixed(2)} L',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Water Tank Volume',
                            style: GoogleFonts.poppins(
                              fontSize: 8,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 163,
                  height: 66,
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(
                            0.2), // Adjust opacity for shadow intensity
                        blurRadius:
                            5.0, // Adjust blur radius for shadow softness
                        spreadRadius:
                            2.0, // Adjust spread radius for shadow size
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                            height: 50,
                            width: 49,
                            padding: const EdgeInsets.all(11),
                            color: const Color(0xFFFDF1E2),
                            child: SvgPicture.asset(
                                'assets/icons/electricalConductivity.svg')),
                      ),
                      const SizedBox(width: 5),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            '${controller.greenhouse.value.greenhouseDatas?[0].ec?.toStringAsFixed(2)} EC',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Electric Conductivity',
                            style: GoogleFonts.poppins(
                              fontSize: 8,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Container(
                  width: 163,
                  height: 66,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(
                            0.2), // Adjust opacity for shadow intensity
                        blurRadius:
                            5.0, // Adjust blur radius for shadow softness
                        spreadRadius:
                            2.0, // Adjust spread radius for shadow size
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                            height: 50,
                            width: 51,
                            padding: const EdgeInsets.all(11),
                            color: const Color(0xFFFBE1EC),
                            child: SvgPicture.asset(
                                'assets/icons/potentialHydrogen.svg')),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            '${controller.greenhouse.value.greenhouseDatas?[0].ph?.toStringAsFixed(2)} pH',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Potential Hydrogen',
                            style: GoogleFonts.poppins(
                              fontSize: 8,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 163,
                  height: 66,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(
                            0.2), // Adjust opacity for shadow intensity
                        blurRadius:
                            5.0, // Adjust blur radius for shadow softness
                        spreadRadius:
                            2.0, // Adjust spread radius for shadow size
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                            height: 50,
                            width: 51,
                            padding: const EdgeInsets.all(11),
                            color: const Color(0xFFEFECFD),
                            child: SvgPicture.asset(
                                'assets/icons/partPerMillion.svg')),
                      ),
                      const SizedBox(width: 6),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            '${controller.greenhouse.value.greenhouseDatas?[0].ppm?.toStringAsFixed(2)} PPM',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Part Per Million',
                            style: GoogleFonts.poppins(
                              fontSize: 8,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );

  Widget _dripIrrigationControl(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 90),
                  child: Text(
                    "Drip Irrigation Control",
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      showModalBottomSheet<void>(
                        isScrollControlled: true,
                        context: context,
                        builder: _setDripBottomSheet,
                      );
                    },
                    icon: const Icon(
                      Icons.settings,
                      color: Colors.black,
                    )),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Container(
                  width: 163,
                  height: 66,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(
                            0.2), // Adjust opacity for shadow intensity
                        blurRadius:
                            5.0, // Adjust blur radius for shadow softness
                        spreadRadius:
                            2.0, // Adjust spread radius for shadow size
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                            height: 50,
                            width: 51,
                            padding: const EdgeInsets.all(11),
                            color: const Color(0xFFE4F8FB),
                            child: SvgPicture.asset(
                                'assets/icons/waterFlowInterval.svg')),
                      ),
                      const SizedBox(width: 9),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            '${controller.greenhouse.value.intervalWaterFlow ?? 0 / 60} minutes',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Water Flow Interval',
                            style: GoogleFonts.poppins(
                              fontSize: 8,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  width: 163,
                  height: 66,
                  padding: const EdgeInsets.all(11),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(
                            0.2), // Adjust opacity for shadow intensity
                        blurRadius:
                            5.0, // Adjust blur radius for shadow softness
                        spreadRadius:
                            2.0, // Adjust spread radius for shadow size
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Container(
                            height: 50,
                            width: 49,
                            padding: const EdgeInsets.all(11),
                            color: const Color(0xFFFBE1EC),
                            child: SvgPicture.asset(
                                'assets/icons/waterFlowTime.svg')),
                      ),
                      const SizedBox(width: 10),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 8),
                          Text(
                            '${controller.greenhouse.value.timeWaterFlow ?? 0 / 60} minutes',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            'Water Flow Time',
                            style: GoogleFonts.poppins(
                              fontSize: 8,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment
                          .start, // Set crossAxisAlignment here
                      children: [
                        Container(
                          width: 163,
                          height: 90,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 5.0,
                                spreadRadius: 2.0,
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: DecoratedBox(
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(
                                          colors: [
                                            Color(0xFFB7E4C7),
                                            Color(0xFFFFFFFF),
                                          ],
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                        ),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        height: 40,
                                        width: 40,
                                        child: SvgPicture.asset(
                                            'assets/icons/flowControl.svg'),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 40,
                                    width: 54,
                                    child: FittedBox(
                                      fit: BoxFit.fill,
                                      child: Switch.adaptive(
                                        value:
                                            controller.isflowBottomSheet.value,
                                        onChanged: (bool value) {
                                          controller.isflowBottomSheet.value =
                                              value;
                                          if (value) {
                                            showModalBottomSheet<void>(
                                              context: context,
                                              builder: _flowBottomSheet,
                                            );
                                          } else {
                                            controller.isflowSwitchOn.value =
                                                value;
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 7),
                              Row(
                                children: [
                                  Text(
                                    " Flow Control",
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          width: 163,
                          height: 66,
                          padding: const EdgeInsets.all(11),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.2),
                                blurRadius: 5.0,
                                spreadRadius: 2.0,
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Container(
                                  height: 50,
                                  width: 49,
                                  padding: const EdgeInsets.all(11),
                                  color: const Color(0xFFFDF1E2),
                                  child: SvgPicture.asset(
                                      'assets/icons/waterFlowToday.svg'),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 8),
                                  Text(
                                    '4 times',
                                    style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Text(
                                    'Water Flowed Today',
                                    style: GoogleFonts.poppins(
                                      fontSize: 8,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      );

  Widget _flowBottomSheet(BuildContext context) => Container(
        height: 302,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Center(
          child: Column(
            children: [
              Container(
                height: 5,
                width: 60,
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 35, right: 30, top: 24, bottom: 24),
                    child: Text(
                      'Are you sure want to turn on drip\nirrigation system?',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 35, right: 30, bottom: 28),
                    child: Text(
                      'The drip irrigation system will be turned on\nonce, click yes if you want to continue.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  MaterialButton(
                    onPressed: () => controller.onFlowSwitch(false),
                    child: Container(
                      margin: const EdgeInsets.only(left: 14, right: 5),
                      height: 54,
                      width: 142,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFFB9A99)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          'No',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFFB9A99),
                          ),
                        ),
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () => controller.onFlowSwitch(true),
                    child: Container(
                      height: 54,
                      width: 142,
                      decoration: BoxDecoration(
                        color: const Color(0xFF52B788),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          'Yes, Continue',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );

  Widget _setDripBottomSheet(BuildContext context) => SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: [
              Container(
                height: 5,
                width: 60,
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 100, top: 24, bottom: 24),
                    child: Text(
                      'Drip Irrigation Setting',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 190.0),
                      child: Text(
                        "Water Flow Interval",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: 327,
                      height: 50,
                      child: FormBuilderTextField(
                        // key: _flowInterval,
                        name: 'waterFlowInterval',
                        cursorColor: const Color(0xFF00AD7C),
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(fontSize: 0.01),
                          hintText: "Enter the Interval",
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 14,
                            color: const Color(0xFFABB3BB),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: const Padding(
                            padding: EdgeInsets.only(
                                left: 14, right: 20, top: 14, bottom: 14),
                            child: Text(
                              'minutes',
                              style: TextStyle(
                                color:
                                    Color(0xFF8A8A8A), // Adjust color as needed
                                fontSize: 14,
                              ),
                            ),
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: SvgPicture.asset(
                                'assets/icons/waterFlowInterval.svg',
                                colorFilter: const ColorFilter.mode(
                                    Color(0xFF00AD7C), BlendMode.srcIn)),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Color(0xFF00AD7C)),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: null,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(right: 190.0),
                      child: Text(
                        "Water Flow Time",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: 327,
                      height: 50,
                      child: FormBuilderTextField(
                        // key: _flowTime,
                        name: 'waterFlowTime',
                        cursorColor: const Color(0xFF00AD7C),
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(fontSize: 0.01),
                          hintText: "Enter the time",
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 14,
                            color: const Color(0xFFABB3BB),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: const Padding(
                            padding: EdgeInsets.only(
                                left: 14, right: 20, top: 14, bottom: 14),
                            child: Text(
                              'minutes',
                              style: TextStyle(
                                color:
                                    Color(0xFF8A8A8A), // Adjust color as needed
                                fontSize: 14,
                              ),
                            ),
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: SvgPicture.asset(
                                'assets/icons/waterFlowTime.svg',
                                colorFilter: const ColorFilter.mode(
                                    Color(0xFF00AD7C), BlendMode.srcIn)),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Color(0xFF00AD7C)),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: null,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  MaterialButton(
                    onPressed: () => controller.onSetDrip(false),
                    child: Container(
                      margin: const EdgeInsets.only(left: 14, right: 14),
                      height: 54,
                      width: 142,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFFB9A99)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFFB9A99),
                          ),
                        ),
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      controller.onSetDrip(true);
                      if (true) {
                        showModalBottomSheet<void>(
                          context: context,
                          builder: _updatedSetDripBottomSheet,
                        );
                      }
                    },
                    child: Container(
                      height: 54,
                      width: 142,
                      decoration: BoxDecoration(
                        color: const Color(0xFF52B788),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          'Change',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      );

  Widget _updatedSetDripBottomSheet(BuildContext context) => Container(
        height: 398,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: Colors.white),
        child: Center(
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 40, bottom: 12),
                width: 132,
                height: 132,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Image.asset('assets/images/updated.png'),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 12),
                child: Text(
                  'Drip Irrigation Updated',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 35, right: 30, bottom: 24),
                child: Text(
                  'Your drip irrigation setting  has been successfully updated, changes are reflected real time.',
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

  Widget _createGreenhouseBottomSheet(BuildContext context) => Container(
        height: 348,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Center(
          child: Column(
            children: [
              Container(
                height: 5,
                width: 60,
                margin: const EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
              Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 105, top: 24, bottom: 40),
                    child: Text(
                      'Create Greenhouse',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 190.0),
                      child: Text(
                        "Greenhouse Name",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      width: 327,
                      height: 50,
                      child: FormBuilderTextField(
                        // key: _greenhouseName,
                        name: 'greenhouseName',
                        cursorColor: const Color(0xFF00AD7C),
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(fontSize: 0.01),
                          hintText: "Enter greenhouse name",
                          hintStyle: GoogleFonts.poppins(
                            fontSize: 14,
                            color: const Color(0xFFABB3BB),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: SvgPicture.asset(
                                'assets/icons/greenhouseIcon.svg',
                                colorFilter: const ColorFilter.mode(
                                    Color(0xFF00AD7C), BlendMode.srcIn)),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Color(0xFF00AD7C)),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: null,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
              Row(
                children: [
                  MaterialButton(
                    onPressed: () => controller.onCreateGreenhouse(false),
                    child: Container(
                      margin: const EdgeInsets.only(left: 14, right: 14),
                      height: 54,
                      width: 142,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFFB9A99)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFFFB9A99),
                          ),
                        ),
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      Get.snackbar("Create Greenhouse",
                          "Success Create Greenhose (Name)",
                          snackPosition: SnackPosition.TOP);
                      controller.onCreateGreenhouse(true);
                    },
                    child: Container(
                      height: 54,
                      width: 142,
                      decoration: BoxDecoration(
                        color: const Color(0xFF52B788),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: Text(
                          'Create',
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
