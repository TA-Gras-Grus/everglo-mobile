import 'package:everglo_mobile/app/helpers/everglo_icon_icons.dart';
import 'package:everglo_mobile/app/helpers/ui_color.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BottomNavbar extends StatelessWidget {
  const BottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomBottomNavigationBarItem(
                icon: Icon(
                  EvergloIcon.homesvg,
                  size: 20,
                ),
                selected: true,
                onTap: () {},
              ),
              CustomBottomNavigationBarItem(
                icon: Icon(
                  EvergloIcon.profile,
                  size: 20,
                ),
                selected: false,
                onTap: () => Get.toNamed('/'),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class CustomBottomNavigationBarItem extends StatelessWidget {
  final Icon icon;
  final bool selected;
  final VoidCallback onTap;

  const CustomBottomNavigationBarItem({
    super.key,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 70,
        padding: const EdgeInsets.symmetric(vertical: 12),
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon.icon,
              size: 32,
              color: selected ? UiColor().primary : Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
