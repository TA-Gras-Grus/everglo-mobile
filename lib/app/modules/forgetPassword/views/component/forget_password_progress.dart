import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_dynamic_icon/flutter_dynamic_icon.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controllers/forget_password_controller.dart';

class ForgetPasswordProgress extends GetView<ForgetPasswordController> {
  final String status;

  ForgetPasswordProgress({Key? key, required this.status}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: Text("Loading"),
            );
          } else {
            return Column(
              children: [
                SizedBox(height: 20),
                Wrap(
                  direction: Axis.horizontal,
                  spacing: -20,
                  children: [
                    _progressDetail(
                        status == 'verify'
                            ? Icons.lock
                            : (status == 'change' ? Icons.check_circle : null),
                        'Get OTP Code',
                        status == 'verify' || status == 'change'),
                    Padding(
                      padding: EdgeInsets.only(top: 25),
                      child: Container(
                        width: 200,
                        height: 1,
                        color: status == 'change'
                            ? Color(0xFF00AD7C)
                            : Colors.grey,
                      ),
                    ),
                    _progressDetail(
                        Icons.lock_open, 'Create New', status == 'change'),
                  ],
                ),
              ],
            );
          }
        }),
      ),
    );
  }

  Widget _progressDetail(IconData? iconData, String text, bool isActive) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: isActive ? Color(0xFF00AD7C) : Colors.white,
            border: Border.all(
                color: isActive ? Color(0xFF00AD7C) : Colors.grey, width: 1),
            borderRadius: BorderRadius.circular(25),
          ),
          padding: EdgeInsets.all(10),
          child: Icon(
            iconData ?? Icons.lock,
            color: isActive ? Colors.white : Colors.grey,
            size: 25,
          ),
        ),
        SizedBox(height: 5),
        Text(
          text,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
            color: isActive ? Color(0xFF00AD7C) : Colors.grey,
          ),
        ),
      ],
    );
  }
}
