// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:everglo_mobile/app/helpers/enum.dart';

class EvergloButton extends StatelessWidget {
  final IconData? leftIcon;
  final String? title;
  final ButtonTitlePosition? titlePosition;
  final IconData? rightIcon;
  final ButtonType type;
  final double? height;
  final double? width;
  final void Function()? onTap;

  const EvergloButton(
      {super.key,
      required this.type,
      this.width,
      this.height,
      this.leftIcon,
      this.title,
      this.titlePosition,
      this.rightIcon,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 50,
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: const Border(
            bottom: BorderSide(color: Color(0xFFF0F0FA), width: 1.5)),
        color: const Color(0xFF52B788),
      ),
      child: MaterialButton(
        onPressed: onTap,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Icon(
                  leftIcon,
                  color: Colors.white,
                ),
              ),
            ),
            Positioned.fill(
              left: titlePosition == ButtonTitlePosition.left ? 50 : 0,
              right: titlePosition == ButtonTitlePosition.right ? 50 : 0,
              child: Align(
                alignment: titlePosition == ButtonTitlePosition.left
                    ? Alignment.centerLeft
                    : titlePosition == ButtonTitlePosition.right
                        ? Alignment.centerRight
                        : Alignment.center,
                child: Text(
                  title ?? '',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  rightIcon,
                  color: Colors.white,
                  size: 28,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
