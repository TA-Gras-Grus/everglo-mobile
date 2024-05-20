import 'package:everglo_mobile/app/helpers/everglo_icon_icons.dart';
import 'package:everglo_mobile/app/helpers/ui_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      color: Colors.white,
      height: 85,
      notchMargin: 10.0,
      shape: const AutomaticNotchedShape(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _bottomAppBarItem(
              context,
              icon: EvergloIcon.homesvg,
              page: 0,
              label: "Home",
              selected: Get.currentRoute == '/home',
            ),
            _bottomAppBarItem(
              context,
              icon: EvergloIcon.profile,
              page: 1,
              label: "Profile",
              selected: Get.currentRoute == '/profile',
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomAppBarItem(BuildContext context,
      {required IconData icon,
      required num page,
      required String label,
      required bool selected}) {
    return ZoomTapAnimation(
      onTap: () {
        if (page == 0) {
          Get.offAllNamed('/home');
        } else if (page == 1) {
          Get.offAllNamed('/profile');
        }
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 30,
              color: selected ? UiColor().primary : Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}

class ScanButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
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
    );
  }
}
