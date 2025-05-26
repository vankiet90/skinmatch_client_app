import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RadarChartWidget extends StatelessWidget {
  final List<double> values;
  final List<String> titles;

  const RadarChartWidget({
    Key? key,
    required this.values,
    required this.titles,
  })  : assert(values.length == titles.length),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // SVG background
          SvgPicture.asset(
            'assets/images/rada_chart.svg',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.contain,
          ),
          // Radar chart on top
          RadarChart(
            RadarChartData(
              dataSets: [
                RadarDataSet(
                  dataEntries: values.map((v) => RadarEntry(value: v)).toList(),
                  fillColor: Colors.pink.withAlpha(51),
                  borderColor: Colors.pink,
                  borderWidth: 2,
                ),
              ],
              radarBackgroundColor: Colors.transparent,

              // Ẩn toàn bộ đường kẻ vòng tròn
              // tickBorderData: const BorderSide(color: Colors.transparent),

              // Ẩn đường kẻ từ tâm ra các trục
              // gridBorderData: const BorderSide(color: Colors.transparent),

              // Ẩn đường viền ngoài của biểu đồ radar
              // radarBorderData: BorderSide.none,

              // Ẩn tick text (các giá trị số)
              ticksTextStyle: const TextStyle(color: Colors.transparent),

              gridBorderData:
                  const BorderSide(color: Colors.transparent, width: 0),
              tickBorderData:
                  const BorderSide(color: Colors.transparent, width: 0),
              radarBorderData:
                  const BorderSide(color: Colors.transparent, width: 0),

              // Tên tiêu đề trục
              getTitle: (index, angle) {
                return RadarChartTitle(
                  text: titles[index],
                  angle: angle,
                );
              },

              // Ẩn viền ngoài (border widget tổng thể)
              borderData: FlBorderData(show: false),
            ),
          ),
        ],
      ),
    );
  }
}
