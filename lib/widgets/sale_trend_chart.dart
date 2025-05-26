import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SaleTrendChart extends StatefulWidget {
  const SaleTrendChart({super.key});

  @override
  State<SaleTrendChart> createState() => _SaleTrendChartState();
}

class _SaleTrendChartState extends State<SaleTrendChart> {
  int selectedIndex = 0;

  final List<String> tabs = ['Day', 'Week', 'Month'];

  final List<FlSpot> data1 = [
    FlSpot(0, 600),
    FlSpot(1, 950),
    FlSpot(2, 890),
    FlSpot(3, 1200),
    FlSpot(4, 550),
    FlSpot(5, 700),
    FlSpot(6, 500),
  ];

  final List<FlSpot> data2 = [
    FlSpot(0, 400),
    FlSpot(1, 600),
    FlSpot(2, 420),
    FlSpot(3, 680),
    FlSpot(4, 550),
    FlSpot(5, 1200),
    FlSpot(6, 1000),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: const Color(0xFFFDEDF4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Sale trend',
            style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF3B0A2B)),
          ),
          const SizedBox(height: 12),
          Row(
            children: List.generate(
              tabs.length,
              (index) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: ChoiceChip(
                  label: Text(tabs[index]),
                  selected: selectedIndex == index,
                  selectedColor: const Color(0xFFFCA3C5),
                  backgroundColor: Colors.white,
                  labelStyle: TextStyle(
                    color: selectedIndex == index
                        ? Colors.white
                        : const Color(0xFFEB2D70),
                    fontWeight: FontWeight.bold,
                  ),
                  onSelected: (_) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          AspectRatio(
            aspectRatio: 1.6,
            child: LineChart(
              LineChartData(
                minY: 0,
                maxY: 1500,
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        const days = [
                          'Mon',
                          'Tue',
                          'Wed',
                          'Thu',
                          'Fri',
                          'Sat',
                          'Sun'
                        ];
                        return Text(
                          days[value.toInt()],
                          style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF3B0A2B)),
                        );
                      },
                      interval: 1,
                    ),
                  ),
                  rightTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles:
                      AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: FlGridData(show: true),
                lineBarsData: [
                  LineChartBarData(
                    spots: data1,
                    isCurved: true,
                    color: Colors.pinkAccent,
                    barWidth: 2,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          Colors.pinkAccent.withOpacity(0.3),
                          Colors.transparent
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                  LineChartBarData(
                    spots: data2,
                    isCurved: true,
                    color: Colors.lightBlueAccent,
                    barWidth: 2,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      gradient: LinearGradient(
                        colors: [
                          Colors.lightBlueAccent.withOpacity(0.3),
                          Colors.transparent
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
