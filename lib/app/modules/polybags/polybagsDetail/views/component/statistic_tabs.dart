import 'package:everglo_mobile/app/modules/polybags/polybagsDetail/controllers/polybags_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';

class StatisticTabs extends GetView<PolybagsDetailController> {
  const StatisticTabs({Key? key}) : super(key: key);

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
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(14)),
                    color: Colors.white,
                  ),
                  child: TabBar(
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorPadding: EdgeInsets.all(6),
                    dividerColor: Colors.transparent,
                    indicator: BoxDecoration(
                      color: Color(0xFF52B788),
                      borderRadius: const BorderRadius.all(Radius.circular(14)),
                    ),
                    labelColor: Colors.white,
                    labelStyle: TextStyle(fontWeight: FontWeight.w700),
                    unselectedLabelColor: Color(0xFF7D8184),
                    unselectedLabelStyle:
                        TextStyle(fontWeight: FontWeight.w400),
                    tabs: [
                      TabItem('NPK'),
                      TabItem('EC/PH'),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
                height: 16), // Add some space between the TabBar and TabBarView
            Expanded(
              child: TabBarView(
                children: [
                  // Your content for the first tab (NPK)
                  DefaultTabController(
                    length: 3,
                    child: SizedBox(
                      height: 200,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(14)),
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(14)),
                                  color: Color(0xFFF2F2F2),
                                ),
                                child: TabBar(
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  indicatorPadding: EdgeInsets.all(6),
                                  dividerColor: Colors.transparent,
                                  indicator: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(14)),
                                  ),
                                  labelColor: Colors.black,
                                  labelStyle:
                                      TextStyle(fontWeight: FontWeight.w700),
                                  unselectedLabelColor: Color(0xFF7D8184),
                                  unselectedLabelStyle:
                                      TextStyle(fontWeight: FontWeight.w600),
                                  tabs: [
                                    TabItem('Daily'),
                                    TabItem('Week'),
                                    TabItem('Month')
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          Expanded(
                            child: TabBarView(
                              children: [
                                Center(child: Text('Daily Content')),
                                Center(child: Text('Week Content')),
                                Center(child: Text('Month Content')),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  DefaultTabController(
                    length: 3,
                    child: SizedBox(
                      height: 200,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: ClipRRect(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(14)),
                              child: Container(
                                height: 48,
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(14)),
                                  color: Color(0xFFF2F2F2),
                                ),
                                child: TabBar(
                                  indicatorSize: TabBarIndicatorSize.tab,
                                  indicatorPadding: EdgeInsets.all(6),
                                  dividerColor: Colors.transparent,
                                  indicator: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(14)),
                                  ),
                                  labelColor: Colors.black,
                                  labelStyle:
                                      TextStyle(fontWeight: FontWeight.w700),
                                  unselectedLabelColor: Color(0xFF7D8184),
                                  unselectedLabelStyle:
                                      TextStyle(fontWeight: FontWeight.w600),
                                  tabs: [
                                    TabItem('Daily'),
                                    TabItem('Week'),
                                    TabItem('Month')
                                  ],
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          const Expanded(
                            child: TabBarView(
                              children: [
                                Center(child: Text('Daily Content')),
                                Center(child: Text('Week Content')),
                                Center(child: Text('Month Content')),
                              ],
                            ),
                          ),
                        ],
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
