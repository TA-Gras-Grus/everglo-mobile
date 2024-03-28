import 'package:everglo_mobile/app/modules/forgetPassword/views/change_password_view.dart';
import 'package:everglo_mobile/app/modules/home/controllers/home_controller.dart';
import 'package:everglo_mobile/app/modules/home/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class BottomNavigationView extends GetView<HomeController> {
  const BottomNavigationView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: EdgeInsets.only(top: 30),
        child: Container(
          height: 70.0,
          width: 70.0,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Color(0xFF00AD7C).withOpacity(0.3),
                spreadRadius: 10,
                blurRadius: 28,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: FittedBox(
            child: FloatingActionButton(
              onPressed: () {},
              child: Icon(Icons.qr_code_2),
              backgroundColor: Color(0xFF00AD7C),
              foregroundColor: Colors.white,
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.white,
        height: 85,
        notchMargin: 10.0,
        shape: AutomaticNotchedShape(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(30),
            ),
          ),
          RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 35, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _bottomAppBarItem(context,
                  icon: Icons.home_filled, page: 0, label: "Home"),
              _bottomAppBarItem(context,
                  icon: Icons.person_outline, page: 1, label: "Profile"),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomAppBarItem(BuildContext context,
      {required icon, required page, required label}) {
    return ZoomTapAnimation(
      onTap: () {
        if (page == 0) {
          Get.to(() => HomeView()); // Example navigation
        } else if (page == 1) {
          Get.to(() => ChangePasswordView()); // Example navigation
        }
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
            )
          ],
        ),
      ),
    );
  }
}
