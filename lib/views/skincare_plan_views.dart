import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/radar_chart_widget.dart';
import '../utils/color_utils.dart';
import '../utils/font_utils.dart';
import '../widgets/product_item.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../viewmodels/skincare_plan_view_model.dart';
import '../models/recommendation_product_model.dart';
import '../viewmodels/scan_history_view_model.dart';

class SkincarePlanViews extends StatefulWidget {
  const SkincarePlanViews({super.key});

  @override
  State<SkincarePlanViews> createState() => _SkincarePlanViewsState();
}

class _SkincarePlanViewsState extends State<SkincarePlanViews> {
  int selectedTabIndex = 0;
  bool isTabLoading = false;

  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ScanHistoryViewModel>();
    final localization = AppLocalizations.of(context)!;
    final viewModel = context.watch<SkincarePlanViewModel>();

    final List<String> categories = [
      localization.cleanse,
      localization.toner,
      localization.serum,
      localization.moisturizer,
      localization.sunscreen,
    ];

    // final List<List<Product>> productLists = [
    //   viewModel.recommendation?.cleansers ?? [],
    //   viewModel.recommendation?.toners ?? [],
    //   viewModel.recommendation?.serums ?? [],
    //   viewModel.recommendation?.moisturizers ?? [],
    //   viewModel.recommendation?.sunscreens ?? [],
    // ];

    final List<List<Product>> productLists = [
      viewModel.recommendation?.moisturizers ?? [],
      viewModel.recommendation?.moisturizers ?? [],
      viewModel.recommendation?.moisturizers ?? [],
      viewModel.recommendation?.moisturizers ?? [],
      viewModel.recommendation?.moisturizers ?? [],
    ];

    return Scaffold(
      backgroundColor: ColorUtils.lightBackgroundSM,
      appBar: AppBar(
        backgroundColor: ColorUtils.lightBackgroundSM,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          localization.skincarePlan,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontUtils.mediumSM,
            color: ColorUtils.neutral[950],
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with avatar and radar chart
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 84,
                        height: 84,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage('assets/images/avatar.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(
                          '${localization.basedOnYourSkinAnalysisOn}\n2/1/2025',
                          style: const TextStyle(
                              fontSize: 14, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),
                  RadarChartWidget(
                    values: vm.scanModel?.skinAnalysis
                            .map((e) => e.value.toDouble())
                            .toList() ??
                        [],
                    titles: vm.scanModel?.skinAnalysis
                            .map((e) => e.name)
                            .toList() ??
                        [],
                  ),

                  // RadarChartWidget(
                  //   values: const [30, 50, 40, 80, 90, 100, 60],
                  //   titles: [
                  //     localization.wrinkles,
                  //     localization.redness,
                  //     localization.nodules,
                  //     localization.pustules,
                  //     localization.eyeBags,
                  //     localization.acne,
                  //     localization.oiliness,
                  //   ],
                  // ),
                  const SizedBox(height: 40),
                ],
              ),
            ),

            // Title
            Text(
              localization.treatmentPlan,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontUtils.mediumSM,
                color: ColorUtils.neutral[900],
              ),
            ),
            const SizedBox(height: 8),

            // Horizontal Tab
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(categories.length, (index) {
                  final isSelected = index == selectedTabIndex;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        isTabLoading = true;
                        selectedTabIndex = index;
                      });

                      Future.delayed(const Duration(seconds: 1), () {
                        setState(() {
                          isTabLoading = false;
                        });
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? ColorUtils.backgroundSM.shade50
                            : Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(
                          color: isSelected
                              ? ColorUtils.borderTextField
                              : Colors.white,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        categories[index],
                        style: const TextStyle(
                          color: ColorUtils.primaryColor,
                          fontWeight: FontUtils.mediumSM,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            const SizedBox(height: 16),

            // Product List
            if (viewModel.isLoading || isTabLoading)
              const Center(
                child: CircularProgressIndicator(
                  color: ColorUtils.primaryColor,
                ),
              )
            else if (viewModel.error != null)
              Text('Error: ${viewModel.error}')
            else
              ...productLists[selectedTabIndex]
                  .map((product) => ProductItem(product: product))
                  .toList(),

            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
