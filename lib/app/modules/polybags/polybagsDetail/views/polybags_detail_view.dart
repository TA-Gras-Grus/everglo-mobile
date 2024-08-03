import 'package:everglo_mobile/app/helpers/everglo_icon_icons.dart';
import 'package:everglo_mobile/app/helpers/ui_color.dart';
import 'package:everglo_mobile/app/modules/polybags/polybagsDetail/views/component/polybags_status.dart';
import 'package:everglo_mobile/app/modules/polybags/polybagsDetail/views/component/statistic_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

import 'package:get/get.dart';

import '../controllers/polybags_detail_controller.dart';

class PolybagsDetailView extends GetView<PolybagsDetailController> {
  PolybagsDetailView({super.key});
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        backgroundColor: const Color(0xFFF6F6F6),
        leading: Padding(
          padding: const EdgeInsets.only(left: 20, right: 5, top: 2, bottom: 5),
          child: Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black, size: 20),
              onPressed: () => Navigator.pop(Get.context!),
            ),
          ),
        ),
        title: const Text('Polybag Detail',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            )),
        centerTitle: true,
      ),
      body: Obx(
        () {
          if (controller.isLoading.value || controller.getMaxY() == 0) {
            return Center(
              child: SpinKitFoldingCube(
                color: UiColor().primary,
              ),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(left: 0),
                    child: Container(
                      height: 66,
                      width: 353,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
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
                      child: Row(
                        children: [
                          const SizedBox(width: 12),
                          Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color(0xFFE5F7ED),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(
                                        0.2), // Adjust opacity for shadow intensity
                                    blurRadius:
                                        5.0, // Adjust blur radius for shadow softness
                                    spreadRadius:
                                        1.0, // Adjust spread radius for shadow size
                                  ),
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SvgPicture.asset(
                                'assets/icons/dayOfPlanted.svg',
                              ),
                            ),
                          ),
                          const SizedBox(width: 11),
                          Padding(
                            padding: const EdgeInsets.only(top: 18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Day Of Planted',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF9FA5B4),
                                  ),
                                ),
                                Text(
                                  controller.toLocalDate(
                                      controller.polybag.value.dayOfPlanted!),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            height: 48,
                            width: 48,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: const Color(0xFFE5F7ED),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(
                                        0.2), // Adjust opacity for shadow intensity
                                    blurRadius:
                                        5.0, // Adjust blur radius for shadow softness
                                    spreadRadius:
                                        1.0, // Adjust spread radius for shadow size
                                  ),
                                ]),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: SvgPicture.asset(
                                'assets/icons/dayAfterPlant.svg',
                              ),
                            ),
                          ),
                          const SizedBox(width: 11),
                          Padding(
                            padding: const EdgeInsets.only(top: 18),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Day After Plant',
                                  style: TextStyle(
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF9FA5B4),
                                  ),
                                ),
                                Text(
                                  '${controller.polybag.value.polybagDatas!.isNotEmpty ? controller.polybag.value.polybagDatas![0].dayAfterPlanted ?? 0 : 0}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  PolybagsStatus(
                    weight: controller.polybag.value.weightOfHarvest.toString(),
                    id: controller.polybag.value.polybagId ?? "",
                    status: controller.polybag.value.isActive!
                        ? 'unharvested'
                        : 'harvested',
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          "Statistic",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        controller.polybag.value.isActive!
                            ? _option(context)
                            : const SizedBox(),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  controller.getMaxY() == 0
                      ? const Center(
                          child: Text(
                            'No data available',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : StatisticTabs(
                          data: controller.getReversedData(),
                          ai: controller.getReversedAiData(),
                          maxY: controller.getMaxY(),
                        ),
                ],
              ),
            );
          }
        },
      ),
    );
  }

  Widget _setPlantWeightSheet(BuildContext context) => SingleChildScrollView(
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
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 100, top: 24, bottom: 24),
                    child: Text(
                      'Harvest current plant',
                      style: TextStyle(
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
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      child: Row(
                        children: [
                          Text(
                            "Harvest weight",
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
                        // key: _flowTime,
                        name: 'harvestWeight',
                        keyboardType: TextInputType.number,
                        cursorColor: const Color(0xFF00AD7C),
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(fontSize: 0.01),
                          hintText: "Enter the harvest weight",
                          hintStyle: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFFABB3BB),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: const Padding(
                            padding: EdgeInsets.only(
                                left: 14, right: 20, top: 14, bottom: 14),
                            child: Text(
                              'gram',
                              style: TextStyle(
                                color:
                                    Color(0xFF8A8A8A), // Adjust color as needed
                                fontSize: 14,
                              ),
                            ),
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Icon(
                              Icons.scale_outlined,
                              color: UiColor().primary,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Color(0xFF00AD7C)),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: null,
                        onChanged: (value) =>
                            {controller.weight.value = value ?? ""},
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
                      controller.onSaveHarvest();
                    },
                    child: Container(
                      height: 54,
                      width: 142,
                      decoration: BoxDecoration(
                        color: const Color(0xFF52B788),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: controller.onHarvest.value
                            ? const SpinKitFadingCircle(
                                color: Colors.white,
                                size: 30,
                              )
                            : const Text(
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

  Widget _newPolybagData(BuildContext context) => SingleChildScrollView(
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
                      'Create new polybag data',
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
                            "EC value",
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
                        name: 'ec',
                        keyboardType: TextInputType.number,
                        cursorColor: const Color(0xFF00AD7C),
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(fontSize: 0.01),
                          hintText: "Enter EC value",
                          hintStyle: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFFABB3BB),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: const Padding(
                            padding: EdgeInsets.only(
                                left: 14, right: 20, top: 14, bottom: 14),
                            child: Text(
                              'EC',
                              style: TextStyle(
                                color:
                                    Color(0xFF8A8A8A), // Adjust color as needed
                                fontSize: 14,
                              ),
                            ),
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Icon(
                              Icons.electric_meter_outlined,
                              color: UiColor().primary,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Color(0xFF00AD7C)),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: null,
                        onChanged: (value) =>
                            {controller.ec.value = value ?? ""},
                      ),
                    ),
                    const SizedBox(height: 15),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 35),
                      child: Row(
                        children: [
                          Text(
                            "pH value",
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
                        name: 'ph',
                        keyboardType: TextInputType.number,
                        cursorColor: const Color(0xFF00AD7C),
                        decoration: InputDecoration(
                          errorStyle: const TextStyle(fontSize: 0.01),
                          hintText: "Enter pH value",
                          hintStyle: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFFABB3BB),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: const Padding(
                            padding: EdgeInsets.only(
                                left: 14, right: 20, top: 14, bottom: 14),
                            child: Text(
                              'pH',
                              style: TextStyle(
                                color:
                                    Color(0xFF8A8A8A), // Adjust color as needed
                                fontSize: 14,
                              ),
                            ),
                          ),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Icon(
                              Icons.water_drop_outlined,
                              color: UiColor().primary,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(color: Color(0xFF00AD7C)),
                              borderRadius: BorderRadius.circular(10)),
                        ),
                        validator: null,
                        onChanged: (value) =>
                            {controller.ph.value = value ?? ""},
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
                      controller.onCreateData();
                    },
                    child: Container(
                      height: 54,
                      width: 142,
                      decoration: BoxDecoration(
                        color: const Color(0xFF52B788),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Center(
                        child: controller.onHarvest.value
                            ? const SpinKitFadingCircle(
                                color: Colors.white,
                                size: 30,
                              )
                            : const Text(
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

  Widget _option(BuildContext context) => SpeedDial(
        icon: EvergloIcon.plant,
        foregroundColor: Colors.white,
        backgroundColor: UiColor().primary,
        direction: SpeedDialDirection.down,
        activeLabel: const Text('Test'),
        children: [
          SpeedDialChild(
            label: 'Create new data',
            child: Icon(
              Icons.add_chart_outlined,
              color: UiColor().primary,
            ),
            onTap: () {
              showModalBottomSheet<void>(
                isScrollControlled: true,
                context: context,
                builder: _newPolybagData,
              );
            },
          ),
          SpeedDialChild(
            label: 'Harvest now',
            child: SvgPicture.asset(
              'assets/icons/harvest.svg',
            ),
            onTap: () {
              showModalBottomSheet<void>(
                isScrollControlled: true,
                context: context,
                builder: _setPlantWeightSheet,
              );
            },
          ),
        ],
      );
}
