import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          body: controller.isLoading.value
              ? Center(
                  child: SingleChildScrollView(
                    child: Stack(
                      children: [
                        FittedBox(
                          fit: BoxFit.cover,
                          child: Image.asset('assets/images/splash.png'),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40.0, top: 70.0),
                          child: RichText(
                            text: const TextSpan(
                              text: "Welcome to\nEverglo",
                              style: TextStyle(
                                  fontSize: 36, fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 680, left: 30),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(27),
                            child: Container(
                              height: 130,
                              width: 325,
                              color: Colors.transparent,
                              child: Stack(
                                children: [
                                  //Blur Effect
                                  BackdropFilter(
                                    filter: ImageFilter.blur(
                                      sigmaX: 30,
                                      sigmaY: 30,
                                    ),
                                    child: Container(),
                                  ),
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(27),
                                      border: Border.all(
                                          color:
                                              Colors.white.withOpacity(0.20)),
                                      gradient: LinearGradient(
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                        colors: [
                                          Colors.white.withOpacity(0.15),
                                          Colors.white.withOpacity(0.05),
                                        ],
                                      ),
                                    ),
                                    padding: const EdgeInsets.all(20),
                                    child: const Column(
                                      children: [
                                        Text(
                                          'Explore The Plant',
                                          style: TextStyle(
                                            fontSize: 20,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 8,
                                        ),
                                        Text(
                                          'You can explores and tracking the condition of the plants.',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: Align(
                              alignment: Alignment.center,
                              child: CircularProgressIndicator(
                                color: Colors.white.withOpacity(0.5),
                                strokeAlign: 5,
                                strokeWidth: 5,
                              )),
                        )
                      ],
                    ),
                  ),
                )
              : const SizedBox()),
    );
  }
}
