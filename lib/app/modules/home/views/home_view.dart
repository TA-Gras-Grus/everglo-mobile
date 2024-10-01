import 'package:everglo_mobile/app/helpers/bottom_navbar.dart';
import 'package:everglo_mobile/app/helpers/button.dart';
import 'package:everglo_mobile/app/helpers/enum.dart';
import 'package:everglo_mobile/app/helpers/everglo_icon_icons.dart';
import 'package:everglo_mobile/app/helpers/global_controller.dart';
import 'package:everglo_mobile/app/helpers/notification_snackbar.dart';
import 'package:everglo_mobile/app/helpers/ui_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

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
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _userInfo(),
                    _greenhouseOption(context),
                    _deviceKeySetting(context),
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
              ),
            );
          }
        },
      ),
      bottomNavigationBar: const BottomNavbar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const ScanButton(),
    );
  }

  Widget _userInfo() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Text(
                    'Welcome, ',
                    style: TextStyle(fontSize: 12, color: Colors.black87),
                  ),
                  Text(
                    '${globalController.user.value.firstName}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w900,
                        fontSize: 12,
                        color: Colors.black87),
                  ),
                ],
              ),
              Text(
                'Grow Smartly Today!',
                style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 15,
                    color: UiColor().primary),
              )
            ],
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(100.0),
            child: Image.network(
              'https://via.placeholder.com/40x40?text=${globalController.user.value.firstName![0].toUpperCase()}',
              width: 40,
              height: 40,
              fit: BoxFit.contain,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) {
                  return child;
                } else {
                  return SpinKitFadingCircle(
                    color: UiColor().primary,
                    size: 20,
                  );
                }
              },
            ),
          ),
        ],
      ));

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
                    width: 345,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(14),
                      color: Colors.white,
                    ),
                    offset: const Offset(-25, -16),
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
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: EvergloButton(
          type: ButtonType.primary,
          leftIcon: EvergloIcon.plant,
          title: 'Your Plants',
          titlePosition: ButtonTitlePosition.left,
          rightIcon: Icons.chevron_right_rounded,
          onTap: () => Get.toNamed('/polybags'),
        ),
      );
  Widget _deviceKeySetting(context) => Padding(
        padding: const EdgeInsets.only(top: 16, right: 24, left: 24),
        child: EvergloButton(
          type: ButtonType.secondary,
          title: 'Device Key Setting',
          titlePosition: ButtonTitlePosition.left,
          leftIcon: Icons.settings_input_antenna_rounded,
          onTap: () {
            showModalBottomSheet<void>(
              isScrollControlled: true,
              context: context,
              builder: (context) => _deviceKeySettingBottomSheet(context),
            );
          },
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
                            controller.greenhouse.value.totalPolybag!
                                .toStringAsFixed(0),
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
                            controller.greenhouse.value.activePolybag!
                                .toStringAsFixed(0),
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
                    controller.onBlowerUpdate.value
                        ? SpinKitFadingCircle(
                            color: UiColor().primary,
                            size: 35,
                          )
                        : SizedBox(
                            height: 40,
                            width: 54,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Switch.adaptive(
                                value:
                                    controller.greenhouse.value.statusBlower ??
                                        false,
                                activeColor: UiColor().primary,
                                onChanged: (bool value) {
                                  controller.onBlowerSwitch(value);
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
                    controller.onHeaterUpdate.value
                        ? SpinKitFadingCircle(
                            color: UiColor().primary,
                            size: 35,
                          )
                        : SizedBox(
                            height: 40,
                            width: 54,
                            child: FittedBox(
                              fit: BoxFit.fill,
                              child: Switch.adaptive(
                                activeColor: UiColor().primary,
                                value:
                                    controller.greenhouse.value.statusHeater ??
                                        false,
                                onChanged: (bool value) {
                                  controller.onHeaterSwitch(value);
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
                            (controller.greenhouse.value.statusWaterTank ??
                                    true)
                                ? 'Fill in'
                                : 'FIll out',
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
                            '${controller.greenhouse.value.ec?.toStringAsFixed(2)} EC',
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
                            '${controller.greenhouse.value.ph?.toStringAsFixed(2)} pH',
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
                            '${controller.greenhouse.value.ppm?.toStringAsFixed(2)} PPM',
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
                                    '${controller.greenhouse.value.countWaterFlow} times',
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
                                  controller.onFlowUpdate.value
                                      ? SpinKitFadingCircle(
                                          color: UiColor().primary,
                                          size: 35,
                                        )
                                      : SizedBox(
                                          height: 40,
                                          width: 54,
                                          child: FittedBox(
                                            fit: BoxFit.fill,
                                            child: Switch.adaptive(
                                              activeColor: UiColor().primary,
                                              value: controller.greenhouse.value
                                                      .statusWaterFlow ??
                                                  false,
                                              onChanged: (bool value) {
                                                showModalBottomSheet<void>(
                                                  context: context,
                                                  builder: _flowBottomSheet,
                                                );
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
                      controller.greenhouse.value.statusWaterFlow!
                          ? 'Are you sure want to turn off drip\nirrigation system?'
                          : 'Are you sure want to turn on drip\nirrigation system?',
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
                      controller.greenhouse.value.statusWaterFlow!
                          ? 'The drip irrigation system will be turned off,\n click yes if you want to continue.'
                          : 'The drip irrigation system will be turned on\nonce, click yes if you want to continue.',
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
                    onPressed: () => Navigator.pop(context),
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
                    onPressed: () => controller.onFlowSwitch(),
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
                        initialValue: controller
                            .greenhouse.value.intervalWaterFlow
                            .toString(),
                        keyboardType: TextInputType.number,
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
                        onChanged: (value) =>
                            {controller.flowInterval.value = value ?? ""},
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
                        initialValue: controller.greenhouse.value.timeWaterFlow
                            .toString(),
                        keyboardType: TextInputType.number,
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
                        onChanged: (value) =>
                            {controller.irrigationTime.value = value ?? ""},
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  MaterialButton(
                    onPressed: () => {Navigator.pop(context)},
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
                      controller.onDripUpdate.value
                          ? ''
                          : controller.onSetDrip();
                    },
                    child: Container(
                      height: 54,
                      width: 142,
                      decoration: BoxDecoration(
                        color: const Color(0xFF52B788),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: controller.onDripUpdate.value
                            ? const SpinKitFadingCircle(
                                color: Colors.white,
                                size: 30,
                              )
                            : Text(
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

  Widget _deviceKeySettingBottomSheet(BuildContext context) =>
      SingleChildScrollView(
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 30),
                    child: Text(
                      'Device Key Setting',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                ],
              ),
              FormBuilder(
                key: _formKey,
                child: Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      child: Row(
                        children: [
                          Text(
                            "Heater Blower Device",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      width: 327,
                      height: 70,
                      padding: const EdgeInsets.only(bottom: 10, top: 0),
                      child: FormBuilderTextField(
                        name: 'heaterBlowerDevice',
                        keyboardType: TextInputType.text,
                        cursorColor: const Color(0xFF00AD7C),
                        initialValue: controller.heaterBlowerDevice.value,
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(fontSize: 0.01),
                          hintText: "Enter Key",
                          hintStyle: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFFABB3BB),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Color(0xFF00AD7C)),
                              borderRadius: BorderRadius.circular(10)),
                          suffix: IconButton(
                            icon: Icon(
                              Icons.qr_code_scanner_rounded,
                              color: UiColor().primary,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              showModalBottomSheet<void>(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) =>
                                    _deviceKeyScannerBottomSheet(
                                        context, 'heaterBlowerDevice'),
                              );
                            },
                          ),
                        ),
                        validator: null,
                        onChanged: (value) =>
                            {controller.heaterBlowerDevice.value = value ?? ""},
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      child: Row(
                        children: [
                          Text(
                            "Drip Irrigation Device",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      width: 327,
                      height: 70,
                      padding: const EdgeInsets.only(bottom: 10, top: 0),
                      child: FormBuilderTextField(
                        name: 'dripIrrigationDevice',
                        keyboardType: TextInputType.text,
                        cursorColor: const Color(0xFF00AD7C),
                        initialValue: controller.dripIrrigationDevice.value,
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(fontSize: 0.01),
                          hintText: "Enter Key",
                          hintStyle: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFFABB3BB),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Color(0xFF00AD7C)),
                              borderRadius: BorderRadius.circular(10)),
                          suffix: IconButton(
                            icon: Icon(
                              Icons.qr_code_scanner_rounded,
                              color: UiColor().primary,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              showModalBottomSheet<void>(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) =>
                                    _deviceKeyScannerBottomSheet(
                                        context, 'dripIrrigationDevice'),
                              );
                            },
                          ),
                        ),
                        validator: null,
                        onChanged: (value) => {
                          controller.dripIrrigationDevice.value = value ?? ""
                        },
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      child: Row(
                        children: [
                          Text(
                            "Water Tank Device",
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 15),
                    Container(
                      width: 327,
                      height: 70,
                      padding: const EdgeInsets.only(bottom: 10, top: 0),
                      child: FormBuilderTextField(
                        name: 'waterTankDevice',
                        keyboardType: TextInputType.text,
                        cursorColor: const Color(0xFF00AD7C),
                        initialValue: controller.waterTankDevice.value,
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(fontSize: 0.01),
                          hintText: "Enter Key",
                          hintStyle: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFFABB3BB),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Color(0xFF00AD7C)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffix: IconButton(
                            icon: Icon(
                              Icons.qr_code_scanner_rounded,
                              color: UiColor().primary,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                              showModalBottomSheet<void>(
                                isScrollControlled: true,
                                context: context,
                                builder: (context) =>
                                    _deviceKeyScannerBottomSheet(
                                        context, 'waterTankDevice'),
                              );
                            },
                          ),
                        ),
                        validator: null,
                        onChanged: (value) => {
                          controller.dripIrrigationDevice.value = value ?? ""
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                children: [
                  MaterialButton(
                    onPressed: () => {Navigator.pop(context)},
                    child: Container(
                      margin: const EdgeInsets.only(left: 14, right: 14),
                      height: 54,
                      width: 142,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFFB9A99)),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFFFB9A99),
                          ),
                        ),
                      ),
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      controller.onConnectDevice();
                    },
                    child: Container(
                      height: 54,
                      width: 142,
                      decoration: BoxDecoration(
                        color: const Color(0xFF52B788),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Center(
                        child: Text(
                          'Save',
                          style: TextStyle(
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

  Widget _deviceKeyScannerBottomSheet(BuildContext context, String type) =>
      SingleChildScrollView(
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom),
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
                  child: Text(
                    'Device Key Scanner',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 350,
                      height: 600,
                      child: MobileScanner(
                        controller: MobileScannerController(
                            detectionSpeed: DetectionSpeed.noDuplicates,
                            autoStart: true),
                        onDetect: (capture) {
                          printInfo(info: capture.barcodes[0].rawValue ?? 'no');
                          final List<Barcode> barcodes = capture.barcodes;
                          NotificationSnackbar().success(
                              'Device key scanned', '${barcodes[0].rawValue}');
                          if (type == 'heaterBlowerDevice') {
                            controller.heaterBlowerDevice.value =
                                barcodes[0].rawValue!;
                          } else if (type == 'dripIrrigationDevice') {
                            controller.dripIrrigationDevice.value =
                                barcodes[0].rawValue!;
                          } else if (type == 'waterTankDevice') {
                            controller.waterTankDevice.value =
                                barcodes[0].rawValue!;
                          }
                          Navigator.pop(context);
                          showModalBottomSheet<void>(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) =>
                                _deviceKeySettingBottomSheet(context),
                          );
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 100,
                )
              ],
            )),
      );
}
