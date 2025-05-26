import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../utils/color_utils.dart';
import '../utils/font_utils.dart';
import '../viewmodels/scan_history_view_model.dart';
import '../widgets/scan_info_section.dart';
import '../widgets/birthday_section.dart';
import '../widgets/gender_section.dart';
import '../widgets/health_status_section.dart';
import '../widgets/additional_insights_section.dart';
import '../widgets/shopping_preference_cection.dart';
import '../widgets/policy_agreement_section.dart';
import '../widgets/allergies_section.dart';
import '../widgets/skin_type.dart';
import '../views/scan_view.dart';
import '../widgets/animated_logo_loading.dart';
import '../views/skincare_plan_views.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../provider/customer_provider.dart';

class ScanHistoryView extends StatefulWidget {
  final bool hasScanned;

  const ScanHistoryView({super.key, required this.hasScanned});

  @override
  State<ScanHistoryView> createState() => _ScanHistoryViewContentState();
}

class _ScanHistoryViewContentState extends State<ScanHistoryView> {
  @override
  Widget build(BuildContext context) {
    final vm = context.watch<ScanHistoryViewModel>();
    final localization = AppLocalizations.of(context)!;

    if (vm.isLoading) {
      return Scaffold(
        backgroundColor: Colors.white,
        body: Center(child: LoadingScreen()),
      );
    }

    return Scaffold(
      backgroundColor: ColorUtils.lightBackgroundSM,
      body: NestedScrollView(
        headerSliverBuilder: (context, _) => [
          SliverAppBar(
            title: Text(
              localization.scanHistory,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontUtils.mediumSM,
                color: ColorUtils.neutral[950],
              ),
            ),
            actions: [
              TextButton.icon(
                onPressed: () async {
                  Provider.of<CustomerProvider>(context, listen: false)
                      .setIsReturningFromHistory(true);
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ScanView()),
                  );

                  // Reload scan data
                  await vm.loadScanData();
                },
                icon: const Icon(Icons.qr_code_scanner,
                    color: ColorUtils.primaryColor),
                label: Text(
                  localization.scanAgain,
                  style: TextStyle(
                    color: ColorUtils.primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
            pinned: false,
            backgroundColor: ColorUtils.lightBackgroundSM,
            elevation: 0,
          ),
        ],
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScanInfoSection(scanModel: vm.scanModel),
              if (!widget.hasScanned) ...[
                const BirthdaySection(),
                const GenderSection(),
              ],
              const SkinTypeAndAllergiesSection(),
              const AllergiesSection(),
              const HealthStatusSection(),
              const AdditionalInsightsSection(),
              const ShoppingPreferenceSection(),
              if (!widget.hasScanned) const PolicyAgreementSection(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding:
            const EdgeInsets.only(top: 16, bottom: 32, left: 16, right: 16),
        child: SizedBox(
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: ColorUtils.primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SkincarePlanViews()),
              );
            },
            child: Text(
              localization.continueText,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
