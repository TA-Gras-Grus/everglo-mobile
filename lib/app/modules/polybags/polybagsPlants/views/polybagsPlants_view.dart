import 'package:everglo_mobile/app/modules/polybags/polybagsPlants/views/component/list_plants.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/polybagsPlants_controller.dart';

class PolybagsPlantsView extends GetView<PolybagsPlantsController> {
  const PolybagsPlantsView({Key? key}) : super(key: key);
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
        title: Text('Your Plants',
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
            return Column(
              children: [
                Expanded(
                    child: ListView(
                  children: const [
                    ListPlants(
                      plantsName: 'Chili',
                      numberOfPolybags: 100,
                      plantsImage: 'assets/images/chiliPlants.png',
                    ),
                    ListPlants(
                      plantsName: 'Melon',
                      numberOfPolybags: 80,
                      plantsImage: 'assets/images/melonPlants.jpeg',
                    ),
                    ListPlants(
                      plantsName: 'Chili',
                      numberOfPolybags: 100,
                      plantsImage: 'assets/images/chiliPlants.png',
                    ),
                    ListPlants(
                      plantsName: 'Melon',
                      numberOfPolybags: 80,
                      plantsImage: 'assets/images/melonPlants.jpeg',
                    ),
                    ListPlants(
                      plantsName: 'Chili',
                      numberOfPolybags: 100,
                      plantsImage: 'assets/images/chiliPlants.png',
                    ),
                    ListPlants(
                      plantsName: 'Melon',
                      numberOfPolybags: 80,
                      plantsImage: 'assets/images/melonPlants.jpeg',
                    ),
                  ],
                )),
              ],
            );
          }
        }),
      ),
    );
  }
}
