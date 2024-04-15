import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class PolybagHeader extends StatelessWidget {
  final String plantsName;
  final String polybagSize;
  final String plantsImage;

  const PolybagHeader({
    super.key,
    required this.plantsName,
    required this.polybagSize,
    required this.plantsImage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16),
      child: Container(
        height: 208,
        width: 353,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.grey
                  .withOpacity(0.2), // Adjust opacity for shadow intensity
              blurRadius: 10.0, // Adjust blur radius for shadow softness
              spreadRadius: 1.0, // Adjust spread radius for shadow size
            ),
          ],
        ),
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 12, top: 14),
                  child: Container(
                    height: 155,
                    width: 327,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.asset(
                        '$plantsImage',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(left: 14, right: 14, top: 8),
              child: Row(
                children: [
                  Text(
                    plantsName,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(width: 180),
                  SvgPicture.asset('assets/icons/plants.svg',
                      color: Color(0xFF00AD7C)),
                  SizedBox(width: 5),
                  Text(
                    polybagSize,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
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
}
