import 'package:everglo_mobile/app/helpers/ui_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';

import '../controllers/send_otp_controller.dart';

class SendOtpView extends GetView<SendOtpController> {
  const SendOtpView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Stack(
            children: [
              Image.asset('assets/images/splash.png'),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 90),
                      Image.asset('assets/images/bubbleLogo.png'),
                      const SizedBox(height: 9),
                      RichText(
                        text: const TextSpan(
                          text: 'Welcome to Everglo',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 240,
                right: 0,
                left: 0,
                child: Container(
                  height: 613,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(28),
                      topRight: Radius.circular(28),
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 25.0),
                        child: Center(
                          child: Container(
                            width: 28,
                            height: 5,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xFFBEBEBE)),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 30, left: 32),
                            child: Stack(
                              children: [
                                Container(
                                  width: 332,
                                  height: 64,
                                  decoration: BoxDecoration(
                                      color: const Color(0xFFEAECF0),
                                      borderRadius: BorderRadius.circular(32)),
                                ),
                                Positioned(
                                  top: 8,
                                  right: 12,
                                  child: Container(
                                    width: 308,
                                    height: 48,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(32)),
                                    child: const Padding(
                                      padding: EdgeInsets.only(left: 2, top: 2),
                                      child: Center(
                                        child: Text(
                                          "OTP Verification",
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Obx(() {
                        if (controller.isLoading.value) {
                          return Container(
                            margin: const EdgeInsets.only(top: 50),
                            child: Center(
                              child: SpinKitFoldingCube(
                                color: UiColor().primary,
                              ),
                            ),
                          );
                        } else {
                          return FormBuilder(
                            key: controller.formKey,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    children: [
                                                      Text(
                                                          'Enter the 4 digit code that has been sent to ${controller.email.value}'),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      Row(
                                                        children: [
                                                          const Text(
                                                              'Not your email?'),
                                                          const SizedBox(
                                                            width: 5,
                                                          ),
                                                          GestureDetector(
                                                            onTap: () {
                                                              Get.back();
                                                            },
                                                            child: Text(
                                                              'Change email',
                                                              style: TextStyle(
                                                                color: UiColor()
                                                                    .primary,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w900,
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                            const SizedBox(height: 15),
                                            SizedBox(
                                              width: 327,
                                              height: 50,
                                              child: OtpTextField(
                                                numberOfFields: 4,
                                                borderColor: UiColor().primary,
                                                //set to true to show as box or false to show as dash
                                                showFieldAsBox: true,
                                                //runs when a code is typed in
                                                onCodeChanged: (String code) {
                                                  //handle validation or checks here
                                                },
                                                //runs when every textfield is filled
                                                onSubmit:
                                                    (String verificationCode) {
                                                  controller.onSendOtp(
                                                      verificationCode);
                                                }, // end onSubmit
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 30,
                                            ),
                                            const Text(
                                              'Haven\'t received the OTP yet?',
                                              style: TextStyle(
                                                  color: Colors.black38),
                                            ),
                                            controller.counter.value != 0
                                                ? Text(
                                                    '${controller.counter.value}',
                                                    style: TextStyle(
                                                      color: UiColor().primary,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w900,
                                                    ),
                                                  )
                                                : GestureDetector(
                                                    onTap: () {
                                                      controller
                                                          .handleResendOtp();
                                                    },
                                                    child: Text(
                                                      'Resend OTP',
                                                      style: TextStyle(
                                                        color:
                                                            UiColor().primary,
                                                        fontSize: 16,
                                                        fontWeight:
                                                            FontWeight.w900,
                                                      ),
                                                    ),
                                                  )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }
                      })
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
