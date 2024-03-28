import 'package:everglo_mobile/app/modules/home/views/component/bottom_navigation_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // bottomNavigationBar: BottomNavigationView(),
      body: Center(
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: Text("Loading"),
            );
          } else {
            return SingleChildScrollView(
              child: Column(
                children: [Text("Ini Home Page")],
              ),
            );
          }
        }),
      ),
    );
  }

  // Widget _userInfo() => Padding(
  //       padding: const EdgeInsets.symmetric(horizontal: 24),
  //       child: Row(
  //         children: [
  //           //Left Side
  //           Row(
  //             children: [
  //               //Avatar
  //               Container(
  //                 width: 60,
  //                 height: 60,
  //                 padding: const EdgeInsets.all(5),
  //                 decoration: BoxDecoration(
  //                   color: Colors.white,
  //                   // border: Border.all(5),
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     );
}
