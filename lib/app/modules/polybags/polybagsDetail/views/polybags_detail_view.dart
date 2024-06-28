import 'package:everglo_mobile/app/helpers/ui_color.dart';
import 'package:everglo_mobile/app/modules/polybags/polybagsDetail/views/component/polybags_status.dart';
import 'package:everglo_mobile/app/modules/polybags/polybagsDetail/views/component/statistic_tabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../controllers/polybags_detail_controller.dart';

class PolybagsDetailView extends GetView<PolybagsDetailController> {
  const PolybagsDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        backgroundColor: Colors.transparent,
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
      body: SingleChildScrollView(
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: SpinKitFoldingCube(
                color: UiColor().primary,
              ),
            );
          } else {
            return Column(
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
                  id: controller.polybag.value.polybagId ?? "",
                  status: controller.polybag.value.isActive!
                      ? 'unharvested'
                      : 'harvested',
                ),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.only(right: 260),
                  child: Text(
                    "Statistic",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const StatisticTabs(),
              ],
            );
          }
        }),
      ),
    );
  }
}
