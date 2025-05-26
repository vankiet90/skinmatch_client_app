import 'package:flutter/material.dart';
import '../utils/font_utils.dart';
import '../widgets/radar_chart_widget.dart';
import '../utils/color_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../models/customer_scan_model.dart';

class ScanInfoSection extends StatelessWidget {
  final CustomerScanModel? scanModel;

  const ScanInfoSection({super.key, required this.scanModel});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    if (scanModel == null) {
      return const Center(child: Text("No scan data available"));
    }

    // Danh sách khóa chuẩn theo thứ tự cố định (internal keys)
    final skinKeys = [
      'wrinkle',
      'redness',
      'nodules',
      'pustules',
      'eye_bags',
      'acne',
      'oiliness',
    ];

    // Map giá trị từ scanModel
    final skinDataMap = {
      for (var item in scanModel!.skinAnalysis) item.name: item.value,
    };

    // Lấy giá trị và tiêu đề theo đúng thứ tự key
    final values = skinKeys.map((key) => skinDataMap[key] ?? 0.0).toList();
    final titles = skinKeys.map((key) {
      final value = (skinDataMap[key] ?? 0.0) * 100;
      final label = _getLocalizedLabel(localization, key);
      return '$label\n${value.toInt()}%';
    }).toList();

    print('🎯 Radar values: $values');
    print('🎯 Radar titles: $titles');

    final nonZeroValues = values.where((v) => v > 0).toList();
    final average = nonZeroValues.isNotEmpty
        ? (nonZeroValues.reduce((a, b) => a + b) / nonZeroValues.length * 100)
            .toInt()
        : 0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: CircleAvatar(
                  radius: 62,
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                ),
              ),
              const SizedBox(height: 40),

              // Radar Chart
              RadarChartWidget(
                values: values,
                titles: titles,
              ),
              const SizedBox(height: 40),

              // Score
              Column(
                children: [
                  Text(
                    localization.skinHealthTitle,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontUtils.regularSM,
                      color: ColorUtils.neutral[900],
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$average',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontUtils.semiBoldSM,
                      height: 1.4,
                      color: ColorUtils.titleAppbarColor,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    localization.average,
                    style: TextStyle(
                      fontSize: 12,
                      color: ColorUtils.modeSkinHealth,
                      fontWeight: FontUtils.semiBoldSM,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              // Description
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: Column(
                  children: [
                    Text(
                      localization.analysis,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontUtils.regularSM,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      localization
                          .darkSpotsOnTheSkinCausedByInadequateSunProtection,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontUtils.regularSM,
                        color: ColorUtils.neutral[700],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Ánh xạ key sang tên đã localize
  String _getLocalizedLabel(AppLocalizations loc, String key) {
    switch (key) {
      case 'wrinkle':
        return loc.wrinkles;
      case 'redness':
        return loc.redness;
      case 'nodules':
        return loc.nodules;
      case 'pustules':
        return loc.pustules;
      case 'eye_bags':
        return loc.eyeBags;
      case 'acne':
        return loc.acne;
      case 'oiliness':
        return loc.oiliness;
      default:
        return key;
    }
  }
}
