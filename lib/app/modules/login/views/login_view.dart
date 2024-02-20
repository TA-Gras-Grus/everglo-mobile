import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Image.asset('assets/images/splash.png'),
            Container(
              child: Padding(
                padding: EdgeInsets.all(92),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/bubbleLogo.png'),
                    SizedBox(height: 9),
                    RichText(
                      text: TextSpan(
                          text: 'Welcome to Everglo',
                          style: GoogleFonts.poppins(
                              fontSize: 20, fontWeight: FontWeight.w700)),
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
                      padding: EdgeInsets.only(top: 25.0),
                      child: Center(
                        child: Container(
                          width: 28,
                          height: 5,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFFBEBEBE)),
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 30, left: 32),
                          child: Stack(
                            children: [
                              Container(
                                width: 332,
                                height: 64,
                                decoration: BoxDecoration(
                                    color: Color(0xFFEAECF0),
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
                                      borderRadius: BorderRadius.circular(32)),
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 2, top: 2),
                                    child: Center(
                                      child: Text(
                                        "Login",
                                        style: GoogleFonts.poppins(
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
                      height: 24,
                    ),
                    Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(right: 190.0),
                          child: Text(
                            "Email or Username",
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(height: 15),
                        SizedBox(
                          width: 327,
                          height: 50,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            //Controller: ,
                            decoration: InputDecoration(
                              hintText: "Enter your email",
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 16, color: Color(0xFFABB3BB)),
                              border: OutlineInputBorder(
                                  // borderSide: BorderSide(
                                  //   color: _isFocus.value
                                  //       ? Color(0xFFD0D0D0)
                                  //       : Color(0xFF00AD7C),
                                  // ),
                                  borderRadius: BorderRadius.circular(10)),
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Image.asset(
                                  'assets/images/mail.png',
                                  color: Color(0xFF8A8D90),
                                ),
                              ),
                              // focusedBorder: OutlineInputBorder(
                              //     borderSide:
                              //         BorderSide(color: Color(0xFF00AD7C)),
                              //     borderRadius: BorderRadius.circular(10)),
                            ),
                            // onFocus: (focused) => _isFocus.value = focused,
                          ),
                        ),
                        SizedBox(height: 20),
                        Padding(
                          padding: EdgeInsets.only(right: 250.0),
                          child: Text(
                            "Password",
                            style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        SizedBox(height: 15),
                        SizedBox(
                          width: 327,
                          height: 50,
                          child: TextFormField(
                            keyboardType: TextInputType.text,
                            //Controller: ,
                            decoration: InputDecoration(
                              hintText: "Enter your password",
                              hintStyle: GoogleFonts.poppins(
                                  fontSize: 16, color: Color(0xFFABB3BB)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              prefixIcon: Padding(
                                padding: EdgeInsets.all(10.0),
                                child: Image.asset(
                                  'assets/images/password.png',
                                ),
                              ),
                              suffixIcon: Padding(
                                padding: EdgeInsets.only(right: 10.0),
                                child: Image.asset(
                                  'assets/images/hideEyes.png',
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 190),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            width: 327,
                            height: 46,
                            decoration: BoxDecoration(
                              color: Color(0xFF52B788),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Text(
                                "Sign In",
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
