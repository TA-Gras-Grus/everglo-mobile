import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  //TODO: Implement ForgetPasswordControllerba
  RxBool isLoading = false.obs;
  final count = 0.obs;

  //Focusnode
  final FocusNode focusNode = FocusNode();
  final focusedIconColor = const Color(0xFF00AD7C);
  final unfocusedIconColor = const Color(0xFF8A8D90);

  //Timer Variable Define Usage
  final Rx<DateTime> _endTime = DateTime.now().obs;
  Rx<Duration> difference = Rx<Duration>(Duration.zero);
  RxBool isTimerStarted = RxBool(false);
  final RxString _timeLeft = RxString('00:00:00');
  String get timeLeft => _timeLeft.value;
  Duration? temporarySecond = const Duration(minutes: 2);
  Timer? timer;
  RxBool isResendButtonEnabled = true.obs;

  @override
  void onInit() {
    ever(isTimerStarted, _handleTimerStartedChange);
    ever(difference, _handleDifferenceChange);
    super.onInit();
    focusNode.addListener(() {
      update();
    });
  }


  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }


  void increment() => count.value++;

  //Timer Function
  void startTimer() {
    isResendButtonEnabled.value = false;
    if (temporarySecond != null) {
      _endTime.value = DateTime.now().add(temporarySecond!);
      updateDifference();
    }
  }

  void updateDifference() {
    difference.value = _endTime.value.difference(DateTime.now());
  }

  void _handleDifferenceChange(Duration event) {
    if (event.inSeconds <= 0) {
      timer?.cancel();
      isTimerStarted.value = false;
      _timeLeft.value = '00:00:00';
      temporarySecond = const Duration(minutes: 2);
      isResendButtonEnabled.value = true;
    } else {
      isTimerStarted.value = true;
      String formatTime(Duration duration) {
        String twoDigits(int n) => n.toString().padLeft(2, '0');
        final String twoDigitMinutes =
            twoDigits(difference.value.inMinutes.remainder(60));
        final String twoDigitSeconds =
            twoDigits(difference.value.inSeconds.remainder(60));
        final String twoDigitHours = twoDigits(difference.value.inHours);
        return '$twoDigitHours:$twoDigitMinutes:$twoDigitSeconds';
      }

      _timeLeft.value = formatTime(difference.value);
    }
  }

  void _handleTimerStartedChange(bool event) {
    if (event) {
      timer = Timer.periodic(const Duration(seconds: 1), (Timer timer) {
        updateDifference();
      });
    } else {
      timer?.cancel();
    }
  }
}
