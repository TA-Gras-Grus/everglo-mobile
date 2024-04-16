import 'package:flutter/material.dart';
import 'package:get/get.dart';

class _GetImpl extends GetInterface {}

// ignore: non_constant_identifier_names
final get = _GetImpl();

class NotificationSnackbar {
  success(String? title, String? message) {
    get.snackbar(
      title ?? '',
      message ?? '',
      snackPosition: SnackPosition.TOP,
      colorText: Colors.white,
      backgroundColor: Colors.green,
      margin: const EdgeInsets.fromLTRB(10, 30, 10, 0),
    );
  }

  error(String? title, String? message) {
    get.snackbar(
      title ?? '',
      message ?? '',
      snackPosition: SnackPosition.TOP,
      colorText: Colors.white,
      backgroundColor: Colors.red,
      margin: const EdgeInsets.fromLTRB(10, 30, 10, 0),
    );
  }
}
