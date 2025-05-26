import 'package:flutter/material.dart';
import '../utils/color_utils.dart';
import '../utils/font_utils.dart';
import '../models/customer_model.dart';
import '../widgets/radar_chart_widget.dart';
import '../views/order_scan_detail.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomerScanHistoryView extends StatefulWidget {
  final CustomerModel customer;
  const CustomerScanHistoryView({super.key, required this.customer});
  @override
  State<CustomerScanHistoryView> createState() =>
      _CustomerScanHistoryViewState();
}

class _CustomerScanHistoryViewState extends State<CustomerScanHistoryView> {
  final List<String> _overviewImagePaths = [
    'assets/images/user_01.png',
    'assets/images/user_02.png',
    'assets/images/user_03.png',
    'assets/images/user_04.png',
  ];

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final customer = widget.customer;
    return Scaffold(
      backgroundColor: ColorUtils.lightBackgroundSM,
      appBar: AppBar(
        backgroundColor: ColorUtils.lightBackgroundSM,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          localization.scanHistoryTitle,
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
            // Customer Summary Card
            _buildCustomerSummaryCard(customer),
            const SizedBox(height: 16),
            _buildAnalysisSection(customer),
            const SizedBox(height: 24),
            // Scan History List
            Text(
              localization.scanHistoryTitle,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontUtils.semiBoldSM,
                color: ColorUtils.neutral[900],
              ),
            ),
            const SizedBox(height: 8),
            _buildScanListItem(context, customer),
            _buildScanListItem(context, customer),
            _buildScanListItem(context, customer),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerSummaryCard(CustomerModel customer) {
    final localization = AppLocalizations.of(context)!;
    return Container(
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
              CircleAvatar(
                radius: 42,
                backgroundImage: customer.avatar != null
                    ? NetworkImage(customer.avatar!)
                    : const AssetImage('assets/images/avatar.png')
                        as ImageProvider,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      customer.name ?? "Esther Howard",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontUtils.semiBoldSM,
                        color: ColorUtils.neutral[900],
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      localization.standard,
                      style: TextStyle(
                        color: ColorUtils.neutral[500],
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: Colors.grey),
          const SizedBox(height: 16),
          RadarChartWidget(
            values: const [30, 80, 60, 40, 20, 90, 50],
            titles: [
              localization.wrinkles,
              localization.redness,
              localization.nodules,
              localization.pustules,
              localization.eyeBags,
              localization.acne,
              localization.oiliness,
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${localization.lastScan}: 30/01/2025',
                style: TextStyle(
                  color: ColorUtils.neutral[500],
                  fontSize: 14,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE0B2), // Light Orange
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  localization.oilSkin,
                  style: const TextStyle(
                      color: Color(0xFFFF9800), fontSize: 12), // Orange
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAnalysisSection(CustomerModel customer) {
    final localization = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localization.overview,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          _buildOverviewImages(),
        ],
      ),
    );
  }

  Widget _buildOverviewImages() {
    return SizedBox(
      height: 70,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          if (index < _overviewImagePaths.length) {
            return ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.asset(
                _overviewImagePaths[index],
                width: 70,
                height: 70,
                fit: BoxFit.cover,
              ),
            );
          } else if (index == _overviewImagePaths.length) {
            return Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: ColorUtils.neutral[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Center(
                child: Text(
                  '+${5 - _overviewImagePaths.length}',
                  style: TextStyle(
                    color: ColorUtils.neutral[600],
                    fontWeight: FontUtils.mediumSM,
                    fontSize: 16,
                  ),
                ),
              ),
            );
          } else {
            return const SizedBox
                .shrink(); // Tránh tạo thêm item nếu vượt quá 5
          }
        },
      ),
    );
  }

  Widget _buildScanListItem(BuildContext context, CustomerModel customer) {
    final localization = AppLocalizations.of(context)!;
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => ScanOrderDetailView(customer: customer)),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Các phần tử trong List Item
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'ID',
                  style: TextStyle(
                    color: ColorUtils.neutral[500],
                    fontSize: 14,
                  ),
                ),
                Text(
                  '${localization.scan} #1234',
                  style: TextStyle(
                    color: const Color(0xFFE57373),
                    fontWeight: FontUtils.mediumSM,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  localization.dateTime,
                  style: TextStyle(
                    color: ColorUtils.neutral[500],
                    fontSize: 14,
                  ),
                ),
                Text(
                  '12/12/2024',
                  style: TextStyle(
                    color: ColorUtils.neutral[800],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  localization.skinType,
                  style: TextStyle(
                    color: ColorUtils.neutral[500],
                    fontSize: 14,
                  ),
                ),
                Text(
                  localization.oil,
                  style: TextStyle(
                    color: ColorUtils.neutral[800],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  localization.skinHeath,
                  style: TextStyle(
                    color: ColorUtils.neutral[500],
                    fontSize: 14,
                  ),
                ),
                Text(
                  '60',
                  style: TextStyle(
                    color: ColorUtils.neutral[800],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  localization.analysis,
                  style: TextStyle(
                    color: ColorUtils.neutral[500],
                    fontSize: 14,
                  ),
                ),
                Expanded(
                  child: Text(
                    localization.drynessOrTightnessOilinessOrCloggedPores,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: ColorUtils.neutral[800],
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
