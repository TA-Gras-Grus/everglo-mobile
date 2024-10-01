import 'package:everglo_mobile/app/helpers/ui_color.dart';
import 'package:everglo_mobile/app/modules/polybags/polybagsLists/views/component/list_polybags.dart';
import 'package:everglo_mobile/app/modules/polybags/polybagsLists/views/component/polybag_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/polybagsLists_controller.dart';

class PolybagsListsView extends GetView<PolybagsListsController> {
  const PolybagsListsView({super.key});
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
        title: Text('Polybag List',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            )),
        centerTitle: true,
      ),
      body: Obx(
        () {
          if (controller.isLoading.value) {
            return Center(
              child: SpinKitFoldingCube(
                color: UiColor().primary,
              ),
            );
          } else {
            return RefreshIndicator(
              onRefresh: () async {
                controller.getPolybags();
              },
              color: UiColor().primary,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    PolybagHeader(
                        plantsName: controller.polybags[0].namePlantType ?? "",
                        polybagSize: controller.polybags[0].generalSize ?? ""),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.only(right: 310, bottom: 20),
                      child: Text(
                        "List",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    controller.polybags.isNotEmpty
                        ? Column(
                            children: controller.polybags
                                .map(
                                  (e) => PolybagsList(
                                    polybagId: e.polybagId ?? "",
                                    dayAfterPlant: e.polybagDatas!.isNotEmpty
                                        ? e.polybagDatas![0].dayAfterPlanted ??
                                            0
                                        : 0,
                                    dayOfPlanted:
                                        controller.toLocalDate(e.dayOfPlanted!),
                                    status: e.isActive!
                                        ? 'unharvesred'
                                        : 'harvested',
                                  ),
                                )
                                .toList(),
                          )
                        : const SizedBox()
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
