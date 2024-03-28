import 'package:everglo_mobile/app/modules/forgetPassword/controllers/forget_password_controller.dart';
import 'package:everglo_mobile/app/modules/forgetPassword/views/component/forget_password_progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'verify_o_t_p_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class VerifyOTPView extends GetView<ForgetPasswordController> {
  VerifyOTPView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: EdgeInsets.only(left: 15.0),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.of(context).pop,
          ),
        ),
        title: Text('Forget Password',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            )),
        centerTitle: true,
      ),
      body: Center(
        child: Obx(() {
          if (controller.isLoading.value) {
            return const Center(
              child: Text("Loading"),
            );
          } else {
            return Column(
              children: [
                SizedBox(
                  height: 115,
                  child: ForgetPasswordProgress(status: "verify"),
                ),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 40),
                      child: Text(
                        "Masukkan 4 digit kode yang telah dikirim \nke email anda.",
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
                FormBuilder(
                  key: _formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 35, vertical: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 68,
                              width: 64,
                              child: FormBuilderTextField(
                                name: 'otp1',
                                style: Theme.of(context).textTheme.titleLarge,
                                cursorColor: Color(0xFF00AD7C),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  hintText: "_",
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide:
                                          BorderSide(color: Color(0xFFC0C0C0))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFF00AD7C)),
                                      borderRadius: BorderRadius.circular(100)),
                                ),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                onSaved: (otp1) {},
                                onChanged: (value) {
                                  if (value!.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: 68,
                              width: 64,
                              child: FormBuilderTextField(
                                name: 'otp2',
                                cursorColor: Color(0xFF00AD7C),
                                style: Theme.of(context).textTheme.titleLarge,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  hintText: "_",
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide:
                                          BorderSide(color: Color(0xFFC0C0C0))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFF00AD7C)),
                                      borderRadius: BorderRadius.circular(100)),
                                ),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                onSaved: (otp2) {},
                                onChanged: (value) {
                                  if (value!.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: 68,
                              width: 64,
                              child: FormBuilderTextField(
                                name: 'otp3',
                                style: Theme.of(context).textTheme.titleLarge,
                                cursorColor: Color(0xFF00AD7C),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  hintText: "_",
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide:
                                          BorderSide(color: Color(0xFFC0C0C0))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFF00AD7C)),
                                      borderRadius: BorderRadius.circular(100)),
                                ),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                onSaved: (otp3) {},
                                onChanged: (value) {
                                  if (value!.length == 1) {
                                    FocusScope.of(context).nextFocus();
                                  }
                                },
                              ),
                            ),
                            SizedBox(
                              height: 68,
                              width: 64,
                              child: FormBuilderTextField(
                                name: 'otp4',
                                style: Theme.of(context).textTheme.titleLarge,
                                cursorColor: Color(0xFF00AD7C),
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  hintText: "_",
                                  enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(100),
                                      borderSide:
                                          BorderSide(color: Color(0xFFC0C0C0))),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xFF00AD7C)),
                                      borderRadius: BorderRadius.circular(100)),
                                ),
                                inputFormatters: [
                                  LengthLimitingTextInputFormatter(1),
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                onSaved: (otp4) {},
                                onChanged: (value) {
                                  if (value!.length == 1) {}
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                      MaterialButton(
                        onPressed: () => controller.onReady,
                        //Validate and save the form values
                        //   _formKey.currentState?.saveAndValidate();
                        //   debugPrint(
                        //       _formKey.currentState?.value.toString());
                        // },
                        child: Container(
                          width: 327,
                          height: 46,
                          decoration: BoxDecoration(
                            color: Color(0xFF52B788),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Text(
                              "Send",
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
                ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Belum menerima kode OTP?",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: Colors.black,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    TextButton(
                      onPressed: controller.isResendButtonEnabled.value
                          ? () => controller.startTimer()
                          : null,
                      child: Text(
                        "Resend",
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(controller.isResendButtonEnabled.value
                              ? 0xFF00AD7C
                              : 0xFFC0C0C0),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Text(
                  "${controller.timeLeft}",
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF00AD7C),
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}
