import 'package:everglo_mobile/app/modules/polybags/polybagsLists/views/component/list_polybags.dart';
import 'package:everglo_mobile/app/modules/polybags/polybagsLists/views/component/polybag_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/polybagsLists_controller.dart';

class PolybagsListsView extends GetView<PolybagsListsController> {
  const PolybagsListsView({Key? key}) : super(key: key);
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
              icon: Icon(Icons.arrow_back, color: Colors.black, size: 20),
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
      body: Center(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: Text('Loading...'),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [
                  PolybagHeader(
                      plantsName: 'Cabe Rawit',
                      polybagSize: '20x15',
                      plantsImage: 'assets/images/chiliPlants.png'),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.only(right: 310),
                    child: Text(
                      "List",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  PolybagsList(
                    polybagId: '3db8c356-72ce-43e9-b2b3-91ef261f66b1',
                    dayAfterPlant: 6,
                    dayOfPlanted: 'January 20, 2023',
                    status: 'harvested',
                  ),
                  SizedBox(height: 16),
                  PolybagsList(
                    polybagId: 'jasd34uw-12da-hsad2-bo21-123kj123kasdag',
                    dayAfterPlant: 10,
                    dayOfPlanted: 'April 22, 2024',
                    status: 'unharvested',
                  ),
                  SizedBox(height: 16),
                  PolybagsList(
                    polybagId: '3db8c356-72ce-43e9-b2b3-91ef261f66b1',
                    dayAfterPlant: 6,
                    dayOfPlanted: 'January 20, 2023',
                    status: 'harvested',
                  ),
                  SizedBox(height: 16),
                  PolybagsList(
                    polybagId: 'jasd34uw-12da-hsad2-bo21-123kj123kasdag',
                    dayAfterPlant: 10,
                    dayOfPlanted: 'April 22, 2024',
                    status: 'unharvested',
                  ),
                  SizedBox(height: 16),
                ],
              ),
            );
          }
        }),
      ),
    );
  }
}
