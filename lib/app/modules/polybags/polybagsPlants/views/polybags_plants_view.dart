import 'package:everglo_mobile/app/helpers/ui_color.dart';
import 'package:everglo_mobile/app/modules/polybags/polybagsPlants/views/component/list_plants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/polybagsPlants_controller.dart';

class PolybagsPlantsView extends GetView<PolybagsPlantsController> {
  const PolybagsPlantsView({super.key});
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
        title: Text('Your Plants',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            )),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/polybags/recap');
        },
        backgroundColor: UiColor().primary,
        child: const Icon(
          Icons.bar_chart_rounded,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(
            child: SpinKitFoldingCube(
              color: UiColor().primary,
            ),
          );
        } else {
          return SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: controller.plantTypes.value.plantType!
                        .map((e) => ListPlants(
                              plantsName:
                                  "${e.name ?? ""} ${e.polybagSize ?? ""}",
                              numberOfPolybags: e.totalPolybag ?? 0,
                              plantsId: e.plantTypeId,
                            ))
                        .toList(),
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
