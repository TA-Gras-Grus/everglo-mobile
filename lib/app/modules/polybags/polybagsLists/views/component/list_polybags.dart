import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class PolybagsList extends StatelessWidget {
  final String polybagId;
  final String dayOfPlanted;
  final int dayAfterPlant;
  final String status;

  const PolybagsList({
    super.key,
    required this.polybagId,
    required this.dayAfterPlant,
    required this.dayOfPlanted,
    required this.status,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 353,
      height: 128,
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
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 18, top: 4),
            child: Row(
              children: [
                Text(
                  'Polybag ID',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 110),
                _harvestStatus(
                  status,
                ),
                Expanded(
                  child: MaterialButton(
                    onPressed: () {},
                    padding: EdgeInsets.only(right: 12),
                    child: Container(
                      width: 22,
                      height: 22,
                      decoration: BoxDecoration(
                        color: Color(0xFF52B788),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/icons/rightArrow.svg',
                          height: 8,
                          width: 5,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18, right: 18),
            child: Row(
              children: [
                Text(
                  polybagId,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF8F9A94),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Row(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18, right: 10),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/dayOfPlanted.svg'),
                          SizedBox(width: 10),
                          Text(
                            'Day of Planted',
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF8F9A94),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 3,
                        left: 50,
                      ),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 90,
                            child: Text(
                              dayOfPlanted,
                              style: GoogleFonts.poppins(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(width: 30),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18, right: 10),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/icons/dayAfterPlant.svg'),
                          SizedBox(width: 10),
                          Text(
                            'Day After Plant',
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF8F9A94),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 3, right: 30),
                      child: Row(
                        children: [
                          Text(
                            '$dayAfterPlant',
                            style: GoogleFonts.poppins(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _harvestStatus(String isActive) {
    bool isActive = status == "harvested";
    return Container(
      width: 96,
      height: 23,
      decoration: BoxDecoration(
        color: isActive ? Color(0xFFD8F3DC) : Color(0xFFFEEDB7),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Center(
        child: Text(
          status == "harvested" ? 'Harvested' : 'Unharvested',
          style: GoogleFonts.poppins(
            fontSize: 10,
            fontWeight: FontWeight.w400,
            color: isActive ? Color(0xFF40916C) : Color(0xFFF79E1B),
          ),
        ),
      ),
    );
  }
}
