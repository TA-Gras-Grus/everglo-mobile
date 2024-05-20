import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        backgroundColor: Colors.transparent,
        leading: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 18, top: 10, bottom: 10),
          child: Container(
            height: 32,
            width: 32,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey
                      .withOpacity(0.2), // Adjust opacity for shadow intensity
                  blurRadius: 10.0, // Adjust blur radius for shadow softness
                  spreadRadius: 1.0, // Adjust spread radius for shadow size
                ),
              ],
            ),
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black, size: 18),
              onPressed: () => Navigator.pop(Get.context!),
            ),
          ),
        ),
        title: Text('Edit Profile',
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            )),
        centerTitle: true,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: Text('Loading...'),
          );
        } else {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 122),
                            child: Container(
                              height: 154,
                              width: 154,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border:
                                    Border.all(color: Colors.white, width: 8),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(
                                        0.2), // Adjust opacity for shadow intensity
                                    blurRadius:
                                        10.0, // Adjust blur radius for shadow softness
                                    spreadRadius:
                                        1.0, // Adjust spread radius for shadow size
                                  ),
                                ],
                                image: const DecorationImage(
                                    image: AssetImage(
                                        'assets/images/profileAdiat.jpeg'),
                                    fit: BoxFit.cover),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 175, top: 125),
                              child: Container(
                                height: 45,
                                width: 45,
                                decoration: BoxDecoration(
                                  color: const Color(0xFF52B788),
                                  borderRadius: BorderRadius.circular(100),
                                  border:
                                      Border.all(color: Colors.white, width: 5),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(
                                          0.2), // Adjust opacity for shadow intensity
                                      blurRadius:
                                          10.0, // Adjust blur radius for shadow softness
                                      spreadRadius:
                                          1.0, // Adjust spread radius for shadow size
                                    ),
                                  ],
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SvgPicture.asset(
                                      'assets/icons/camera.svg'),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  const SizedBox(height: 10),
                  FormBuilder(
                    key: controller.editFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Full Name",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: 327,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors
                                  .white, // Set your desired background color
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: FormBuilderTextField(
                              name: 'fullname',
                              cursorColor: const Color(0xFF00AD7C),
                              textAlignVertical: TextAlignVertical.top,
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                errorStyle: const TextStyle(fontSize: 0.01),
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(
                                          0xFFE5E7EB)), // Set your desired color
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xFF00AD7C)),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              initialValue: controller.fullname.value,
                              onChanged: (value) =>
                                  controller.fullname.value = value ?? '',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Email",
                          style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: Colors.black,
                              fontWeight: FontWeight.w500),
                        ),
                        const SizedBox(height: 15),
                        SizedBox(
                          width: 327,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors
                                  .white, // Set your desired background color
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: FormBuilderTextField(
                              // key: _emailKey,
                              name: 'email',
                              cursorColor: const Color(0xFF00AD7C),
                              decoration: InputDecoration(
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 0, horizontal: 10),
                                errorStyle: const TextStyle(fontSize: 0.01),
                                hintStyle: GoogleFonts.poppins(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: const BorderSide(
                                      color: Colors.white, width: 3),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Color(
                                          0xFFE5E7EB)), // Set your desired color
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: const BorderSide(
                                        color: Color(0xFF00AD7C)),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              style: const TextStyle(fontSize: 16),
                              initialValue: controller.email.value,
                              onChanged: (value) =>
                                  controller.email.value = value ?? '',
                            ),
                          ),
                        ),
                        const SizedBox(height: 240),
                        GestureDetector(
                          onTap: controller.isLoading.value
                              ? null
                              : () => controller.handleSave(),
                          child: Container(
                            width: 327,
                            height: 46,
                            decoration: BoxDecoration(
                              color: const Color(0xFF52B788),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: controller.isLoading.value
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : Text(
                                      "Save Changes",
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
                ],
              ),
            ),
          );
        }
      }),
    );
  }
}
