import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(children: [
          Image.asset('assets/images/splash.png'),
          Padding(
            padding: EdgeInsets.only(left: 40.0, top: 70.0),
            child: RichText(
                text: TextSpan(
              text: "Welcome to\nEverglo",
              style: GoogleFonts.poppins(
                  fontSize: 36, fontWeight: FontWeight.w700),
            )),
          ),
          Padding(
            padding: EdgeInsets.only(top: 680, left: 30),
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
                        border:
                            Border.all(color: Colors.white.withOpacity(0.20)),
                        gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.white.withOpacity(0.15),
                              Colors.white.withOpacity(0.05),
                            ]),
                      ),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          Text(
                            'Explore The Plant',
                            style: GoogleFonts.poppins(
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
                                  fontWeight: FontWeight.w400)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
