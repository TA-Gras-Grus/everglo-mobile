import 'package:everglo_mobile/app/helpers/ui_color.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';

import '../controllers/recap_controller.dart';

class RecapView extends GetView<RecapController> {
  const RecapView({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate
        // Add other delegates if needed
      ],
      supportedLocales: const [
        Locale('en', 'US'), // Add other supported locales
        Locale('id', 'ID'),
      ],
      // Wrap the RecapView widget with MaterialApp
      home: Scaffold(
        appBar: AppBar(
          leadingWidth: 80,
          backgroundColor: Colors.white,
          leading: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 5, top: 2, bottom: 5),
            child: Container(
              height: 32,
              width: 32,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: IconButton(
                icon:
                    const Icon(Icons.arrow_back, color: Colors.black, size: 20),
                onPressed: () => Navigator.pop(Get.context!),
              ),
            ),
          ),
          title: const Text('Harvest Recapitulation',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              )),
          centerTitle: true,
        ),
        body: Obx(
          () => controller.isLoading.value
              ? Center(child: SpinKitFoldingCube(color: UiColor().primary))
              : SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 20),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: FormBuilder(
                                    key: controller.formKey,
                                    child: Column(children: [
                                      FormBuilderDateRangePicker(
                                        name: "filterDate",
                                        initialValue: controller
                                                    .dateRange.value.isEmpty ||
                                                controller.dateRange.value == ""
                                            ? null
                                            : DateTimeRange(
                                                start: DateTime.parse(controller
                                                    .dateRange
                                                    .split(" - ")[0]),
                                                end: DateTime.parse(controller
                                                    .dateRange
                                                    .split(" - ")[1])),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2100),
                                        format: DateFormat('dd-MM-yyyy'),
                                        locale: const Locale('id', 'ID'),
                                        allowClear: true,
                                        decoration: InputDecoration(
                                          labelText: 'Filter by Date',
                                          labelStyle: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 12),
                                          border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(5),
                                          ),
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 10, vertical: 0),
                                          suffixIcon: Icon(
                                            Icons.date_range,
                                            color: UiColor().primary,
                                          ),
                                        ),
                                        onChanged: (value) {
                                          controller.dateRange.value =
                                              value != null
                                                  ? value.toString()
                                                  : "";
                                          controller.isLoading.value = true;
                                          controller.getRecap().then((value) {
                                            controller.isLoading.value = false;
                                          });
                                        },
                                      )
                                    ])),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 70,
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 500,
                            child: controller.recaps.value.recap!.isNotEmpty
                                ? BarChart(
                                    BarChartData(
                                      alignment: BarChartAlignment.spaceAround,
                                      barGroups: _buildBarGroups(),
                                      titlesData: FlTitlesData(
                                        leftTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            showTitles: true,
                                            getTitlesWidget: (value, meta) {
                                              return SizedBox(
                                                width: 60,
                                                height: 40,
                                                child: Center(
                                                  child: Text(
                                                    value.toInt().toString() +
                                                        controller.recaps.value
                                                            .recap![0].unit
                                                            .toString(),
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 8,
                                                        overflow: TextOverflow
                                                            .visible),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        bottomTitles: AxisTitles(
                                          sideTitles: SideTitles(
                                            showTitles: true,
                                            reservedSize: 20,
                                            getTitlesWidget: (value, meta) {
                                              return SizedBox(
                                                width: 40,
                                                height: 40,
                                                child: Center(
                                                  child: Text(
                                                    controller
                                                        .recaps
                                                        .value
                                                        .recap![value.toInt()]
                                                        .label!,
                                                    style: const TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10,
                                                        overflow: TextOverflow
                                                            .visible),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                        ),
                                        rightTitles: const AxisTitles(
                                          sideTitles:
                                              SideTitles(showTitles: false),
                                        ),
                                        topTitles: const AxisTitles(
                                          sideTitles:
                                              SideTitles(showTitles: false),
                                        ),
                                      ),
                                    ),
                                  )
                                : const Center(
                                    child: Text('No data found'),
                                  ),
                          ),
                        ],
                      )),
                ),
        ),
      ),
    );
  }

  List<BarChartGroupData> _buildBarGroups() {
    return List.generate(controller.recaps.value.recap!.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
              toY: controller.recaps.value.recap![index].weight!.toDouble(),
              color: UiColor().primary),
        ],
        showingTooltipIndicators: [0],
      );
    });
  }
}
