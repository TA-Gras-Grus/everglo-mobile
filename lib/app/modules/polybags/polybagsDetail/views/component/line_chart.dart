import 'package:everglo_mobile/app/data/models/polybag.dart';
import 'package:everglo_mobile/app/helpers/ui_color.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class EvergloChart extends StatelessWidget {
  final List<PolybagData> data;
  final List<AiPredictionElement> ai;
  final int maxY;
  const EvergloChart(
      {super.key, required this.data, required this.ai, required this.maxY});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        borderData: FlBorderData(
          show: true,
          border: Border.all(
            color: const Color(0xff37434d),
            width: 0,
          ),
        ),
        gridData: const FlGridData(show: true),
        titlesData: FlTitlesData(
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 20,
              getTitlesWidget: (value, meta) {
                return Text(
                  ai.isNotEmpty
                      ? 'DAP${ai[value.toInt()].dayAfterPlanted!.toInt()}'
                      : 'DAP${value.toInt()}',
                  style: const TextStyle(
                    color: Color(0xff68737d),
                    fontWeight: FontWeight.bold,
                    fontSize: 6,
                  ),
                );
              },
            ),
          ),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 22,
              getTitlesWidget: (value, meta) {
                return Text(
                  value.toInt().toString(),
                  style: const TextStyle(
                    color: Color(0xff67727d),
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                );
              },
            ),
          ),
          rightTitles: const AxisTitles(
              sideTitles: SideTitles(
            showTitles: false,
          )),
          topTitles: const AxisTitles(
              sideTitles: SideTitles(
            showTitles: false,
          )),
        ),
        minX: 0,
        maxX: ai.length.toDouble() != 0 ? ai.length.toDouble() - 1 : 1,
        minY: 0,
        maxY: maxY.toDouble(),
        lineBarsData: [
          LineChartBarData(
            spots: data
                .map((e) => FlSpot(e.dayAfterPlanted!.toDouble(), e.ec!))
                .toList(),
            // data.map
            //     data
            //     .asMap()
            //     .map((index, e) =>
            //         MapEntry(index, FlSpot(index.toDouble(), e.ec!)))
            //     .values
            //     .toList(),
            isCurved: true,
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: const FlDotData(
              show: true,
            ),
            belowBarData: BarAreaData(
              show: true,
              color: Colors.green.shade100,
            ),
            color: UiColor().primary,
          ),
          data.isNotEmpty
              ? data.last.dayAfterPlanted != 90
                  ? LineChartBarData(
                      spots: ai
                          .map((e) =>
                              FlSpot(e.dayAfterPlanted!.toDouble(), e.ec!))
                          .toList(),
                      // ai
                      //     .asMap()
                      //     .map((index, e) =>
                      //         MapEntry(index, FlSpot(index.toDouble(), e.ec!)))
                      //     .values
                      //     .toList(),
                      isCurved: true,
                      barWidth: 2,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(
                        show: true,
                      ),
                      belowBarData: BarAreaData(
                          show: true, color: Colors.red.withOpacity(0.2)),
                      color: UiColor().danger,
                    )
                  : LineChartBarData()
              : LineChartBarData(
                  spots: ai
                      .map((e) => FlSpot(e.dayAfterPlanted!.toDouble(), e.ec!))
                      .toList(),
                  // ai
                  // .asMap()
                  // .map((index, e) =>
                  //     MapEntry(index, FlSpot(index.toDouble(), e.ec!)))
                  // .values
                  // .toList(),
                  isCurved: true,
                  barWidth: 2,
                  isStrokeCapRound: true,
                  dotData: const FlDotData(
                    show: true,
                  ),
                  belowBarData: BarAreaData(
                      show: true, color: Colors.red.withOpacity(0.2)),
                  color: UiColor().danger,
                ),
        ],
      ),
    );
  }
}
