import 'package:flutter/material.dart';
import 'dart:math';

class CustomDonutChart extends StatelessWidget {
  final String title;
  final Map<String, double> dataMap;
  final List<Color> colorList;

  const CustomDonutChart({
    Key? key,
    required this.title,
    required this.dataMap,
    required this.colorList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final total = dataMap.values.reduce((a, b) => a + b);
    final center = 150.0;
    final radius = 100.0;

    final percentages =
        dataMap.entries.map((e) => e.value / total * 100).toList();
    final angles = dataMap.entries.map((e) => e.value / total * 360).toList();

    return Container(
      margin: const EdgeInsets.all(8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.pink.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: center * 2,
            height: center * 2,
            child: Stack(
              children: [
                CustomPaint(
                  size: Size(center * 2, center * 2),
                  painter:
                      DonutChartPainter(dataMap: dataMap, colorList: colorList),
                ),
                ..._buildPercentageLabels(percentages, angles, center, radius),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPercentageLabels(List<double> percentages,
      List<double> angles, double center, double radius) {
    List<Widget> widgets = [];
    double startAngle = -90;

    for (int i = 0; i < percentages.length; i++) {
      final angleInRad = (startAngle + angles[i] / 2) * pi / 180;
      final dx = center + (radius + 30) * cos(angleInRad);
      final dy = center + (radius + 30) * sin(angleInRad);

      widgets.add(Positioned(
        left: dx - 20,
        top: dy - 20,
        child: Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.pink.withOpacity(0.3),
                blurRadius: 6,
                offset: const Offset(0, 3),
              )
            ],
          ),
          child: Text(
            '${percentages[i].round()}%',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
              fontSize: 12,
            ),
          ),
        ),
      ));

      startAngle += angles[i];
    }

    return widgets;
  }
}

class DonutChartPainter extends CustomPainter {
  final Map<String, double> dataMap;
  final List<Color> colorList;

  DonutChartPainter({
    required this.dataMap,
    required this.colorList,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final total = dataMap.values.reduce((a, b) => a + b);
    final center = Offset(size.width / 2, size.height / 2);
    final radius = 100.0;
    final strokeWidth = 40.0;

    double startAngle = -pi / 2;

    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    int i = 0;
    for (var entry in dataMap.entries) {
      final sweepAngle = (entry.value / total) * 2 * pi;
      paint.color = colorList[i % colorList.length];

      canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );

      startAngle += sweepAngle;
      i++;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
