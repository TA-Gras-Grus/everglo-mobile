// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

import 'package:everglo_mobile/app/modules/polybags/polybagsDetail/controllers/polybags_detail_controller.dart';

class PolybagsStatus extends GetView<PolybagsDetailController> {
  final String status;
  final String id;

  const PolybagsStatus({
    required this.status,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 0),
      child: Container(
        height: 66,
        width: 353,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey
                    .withOpacity(0.2), // Adjust opacity for shadow intensity
                blurRadius: 10.0, // Adjust blur radius for shadow softness
                spreadRadius: 1.0, // Adjust spread radius for shadow size
              ),
            ]),
        child: _harvestStatus(status),
      ),
    );
  }

  Widget _harvestStatus(String isActive) {
    bool isActive = status == "harvested";
    return Row(
      children: [
        const SizedBox(width: 12),
        Container(
          height: 48,
          width: 48,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color:
                  isActive ? const Color(0xFFE5F7ED) : const Color(0xFFFEEDB7),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey
                      .withOpacity(0.2), // Adjust opacity for shadow intensity
                  blurRadius: 5.0, // Adjust blur radius for shadow softness
                  spreadRadius: 1.0, // Adjust spread radius for shadow size
                ),
              ]),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: isActive
                ? SvgPicture.asset(
                    'assets/icons/harvest.svg',
                  )
                : SvgPicture.asset('assets/icons/unharvested.svg'),
          ),
        ),
        const SizedBox(width: 11),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    id,
                    style: TextStyle(fontSize: 10, color: Colors.black54),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(width: 10),
                    Container(
                      height: 6,
                      width: 6,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isActive
                            ? const Color(0xFF40916C)
                            : const Color(0xFFF79E1B),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      status == "harvested" ? 'Harvested' : 'Unharvested',
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
