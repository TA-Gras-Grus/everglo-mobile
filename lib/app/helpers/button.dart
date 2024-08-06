// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:everglo_mobile/app/helpers/ui_color.dart';
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
  final String? shadow;
  final void Function()? onTap;

  const EvergloButton(
      {super.key,
      required this.type,
      this.shadow,
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 3),
          )
        ],
        color: type == ButtonType.primary ? Color(0xFF52B788) : Colors.white,
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
                  color: type == ButtonType.primary
                      ? Colors.white
                      : UiColor().primary,
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
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: type == ButtonType.primary
                        ? Colors.white
                        : UiColor().primary,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  rightIcon,
                  color: type == ButtonType.primary
                      ? Colors.white
                      : UiColor().primary,
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
