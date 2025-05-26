import 'package:flutter/material.dart';
import '../utils/color_utils.dart';
import '../utils/font_utils.dart';
import '../models/customer_model.dart';
import '../widgets/radar_chart_widget.dart';
import '../views/purchase_detail_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
// import 'package:cached_network_image/cached_network_image.dart';

class ScanOrderDetailView extends StatefulWidget {
  final CustomerModel customer;
  const ScanOrderDetailView({super.key, required this.customer});

  @override
  State<ScanOrderDetailView> createState() => _ScanOrderDetailViewState();
}

class _ScanOrderDetailViewState extends State<ScanOrderDetailView> {
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
          localization.scanDetail,
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
            _buildCustomerSummaryCard(customer),
            const SizedBox(height: 16),
            _buildAnalysisSection(customer),
            const SizedBox(height: 16),
            _buildScanListItem(context, customer),
            const SizedBox(height: 16),
            _buildProductsSection(),
          ],
        ),
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
            localization.analysis,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            localization.darkSpotsOnTheSkinCausedByInadequateSunProtection,
            style: const TextStyle(fontSize: 14),
          ),
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

  Widget _buildProductsSection() {
    final localization = AppLocalizations.of(context)!;
    final products = [
      {'name': 'Lumiere Cleanser', 'qty': 'x1', 'type': 'Serum'},
      {'name': 'Blissé Toner', 'qty': 'x1', 'type': 'Serum'},
      {'name': 'AuraBella Serum', 'qty': 'x1', 'type': 'Serum'},
      {'name': 'Radianté Moisturizer', 'qty': 'x1', 'type': 'Serum'},
      {'name': 'Elviora Sunscreen', 'qty': 'x1', 'type': 'Serum'},
      {'name': 'Serum', 'qty': 'x1', 'type': 'Serum'},
    ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                localization.products,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PurchaseDetailView(),
                    ),
                  );
                },
                child: Text(
                  localization.viewOrder,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontUtils.semiBoldSM,
                    color: ColorUtils.backgroundSM.shade500,
                    decoration: TextDecoration.underline,
                    decorationColor: ColorUtils.backgroundSM.shade500,
                  ),
                ),
              ),
            ],
          ),
          ...products.map((product) => _buildProductItem(product)).toList(),
        ],
      ),
    );
  }

  Widget _buildProductItem(Map<String, String> product) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Image.asset(
              'assets/images/oil_product.png',
              width: 60,
              height: 60,
            ),

            // child: CachedNetworkImage(
            //   imageUrl: 'https://example.com/images/shopping_bag.png',
            //   width: 60,
            //   height: 60,
            //   placeholder: (context, url) =>
            //       const CircularProgressIndicator(strokeWidth: 2),
            //   errorWidget: (context, url, error) => const Icon(Icons.error),
            // ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product['name']!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                if (product['type']!.isNotEmpty)
                  Text(
                    product['type']!,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
              ],
            ),
          ),
          Text(
            product['qty']!,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildScanListItem(BuildContext context, CustomerModel customer) {
    final localization = AppLocalizations.of(context)!;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ID row with scan number
          _buildDetailRow('ID', '${localization.scan} #1234', isFirst: true),

          // Date time row
          _buildDetailRow(localization.dateTime, '12/12/2024'),

          // Served by row
          _buildDetailRow(localization.servedBy, 'Anna'),

          // Skin type row
          _buildDetailRow(localization.skinType, 'Oil'),

          // Allergy row
          _buildDetailRow(localization.allergy, 'Allergy name'),

          // Health Status row
          _buildDetailRow(localization.healthStatus, 'None'),

          // Skin conditions row
          _buildDetailRow(localization.skinConditions, 'Eczema'),

          // Insights section
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localization.insights,
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
    );
  }

  Widget _buildDetailRow(String label, String value, {bool isFirst = false}) {
    return Padding(
      padding: EdgeInsets.only(top: isFirst ? 0 : 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontUtils.regularSM,
                color: ColorUtils.neutral[600],
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.end,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontUtils.mediumSM,
                color: ColorUtils.neutral[900],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Keep your existing _buildCustomerSummaryCard method
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
            values: const [80, 80, 80, 80, 80, 80, 80],
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
                '${localization.lastScan} 30/01/2025',
                style: TextStyle(
                  color: ColorUtils.neutral[500],
                  fontSize: 14,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFFFFE0B2),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Text(
                  localization.oilSkin,
                  style:
                      const TextStyle(color: Color(0xFFFF9800), fontSize: 12),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
