import 'package:everglo_mobile/app/helpers/ui_color.dart';
import 'package:everglo_mobile/app/modules/polybags/polybagsDetail/controllers/polybags_detail_controller.dart';
import 'package:everglo_mobile/app/modules/polybags/polybagsDetail/views/component/line_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class StatisticTabs extends GetView<PolybagsDetailController> {
  final dynamic data;
  final dynamic ai;
  final int maxY;
  const StatisticTabs({super.key, this.data, this.ai, required this.maxY});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SizedBox(
        height: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(14)),
                child: Container(
                  height: 48,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                    color: Colors.white,
                  ),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorPadding: const EdgeInsets.all(6),
                    dividerColor: Colors.transparent,
                    indicator: const BoxDecoration(
                      color: Color(0xFF52B788),
                      borderRadius: BorderRadius.all(Radius.circular(14)),
                    ),
                    labelColor: Colors.white,
                    labelStyle: const TextStyle(fontWeight: FontWeight.w700),
                    unselectedLabelColor: const Color(0xFF7D8184),
                    unselectedLabelStyle:
                        const TextStyle(fontWeight: FontWeight.w400),
                    tabs: [
                      TabItem('EC'),
                      TabItem('NPK'),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
                height: 16), // Add some space between the TabBar and TabBarView
            Expanded(
              child: TabBarView(
                children: [
                  // Your content for the first tab (NPK)
                  DefaultTabController(
                    length: 1,
                    child: Column(
                      children: [
                        Container(
                          height: 350,
                          padding: const EdgeInsets.all(20),
                          child: EvergloChart(
                            data: data,
                            ai: ai,
                            maxY: maxY,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(children: [
                              Icon(
                                Icons.circle,
                                color: UiColor().primary,
                              ),
                              const Text(
                                'Polybag Statistic',
                                style: TextStyle(color: Colors.black54),
                              )
                            ]),
                            const SizedBox(
                              width: 20,
                            ),
                            Row(children: [
                              Icon(
                                Icons.circle,
                                color: UiColor().danger,
                              ),
                              const Text(
                                'AI Prediction',
                                style: TextStyle(color: Colors.black54),
                              )
                            ])
                          ],
                        )
                      ],
                    ),
                  ),
                  const DefaultTabController(
                    length: 3,
                    child: Center(
                      child: Text(
                        'Coming Soon!',
                        style: TextStyle(fontSize: 12, color: Colors.black54),
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

  Widget TabItem(String title) {
    return Tab(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
