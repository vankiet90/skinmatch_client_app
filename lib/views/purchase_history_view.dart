import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../views/purchase_detail_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PurchaseHistoryView extends StatelessWidget {
  const PurchaseHistoryView({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFFFCE4EC), // Light Pink Background
      appBar: AppBar(
        backgroundColor: const Color(0xFFFCE4EC),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          localization.purchaseDetail,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Color(0xFF880E4F), // Dark Pink Title
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCustomerInfoCard(context),
            const SizedBox(height: 16),
            _buildSummaryCard(context),
            const SizedBox(height: 16),
            _buildSearchBar(context),
            const SizedBox(height: 16),
            _buildFilterRow(context),
            const SizedBox(height: 16),
            _buildOrderListItem(context, onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PurchaseDetailView(),
                ),
              );
            }),
            _buildOrderListItem(context, onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PurchaseDetailView(),
                ),
              );
            }),
            _buildOrderListItem(context, onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PurchaseDetailView(),
                ),
              );
            }),
            _buildOrderListItem(context, onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const PurchaseDetailView(),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildCustomerInfoCard(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
                'https://via.placeholder.com/100/FFC107/000000?Text=User'), // Placeholder Image
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Esther Howard',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 4),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey.shade400, width: 1),
                ),
                child: Text(
                  localization.standard,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            children: [
              Text(
                localization.totalPurchase,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                '24',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          Container(
            height: 30,
            width: 1,
            color: Colors.grey.shade300,
          ),
          Column(
            children: [
              Text(
                localization.totalValue,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 4),
              Text(
                '100 \$',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: localization.search,
          prefixIcon: Icon(Icons.search, color: Colors.grey),
          border: InputBorder.none,
          contentPadding: EdgeInsets.all(12.0),
        ),
      ),
    );
  }

  Widget _buildFilterRow(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.0),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  localization.date,
                  style: TextStyle(color: Colors.grey),
                ),
                Icon(Icons.arrow_drop_down, color: Colors.grey),
              ],
            ),
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: const Color(0xFFE91E63)),
          ),
          child: const Icon(
            Icons.swap_vert,
            color: Color(0xFFE91E63),
          ),
        ),
      ],
    );
  }

  Widget _buildOrderListItem(BuildContext context,
      {required VoidCallback onTap}) {
    final now = DateTime.now();
    final formattedDate = DateFormat('HH:mm, MMM d').format(now);
    final localization = AppLocalizations.of(context)!;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12.0),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12.0),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              formattedDate,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${localization.order} #2025-001',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: const Color(0xFFE91E63),
                  ),
                  child: Text(localization.viewScan),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              '${localization.servedBy} Anna',
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFF8BC34A).withAlpha(51), // Light Green
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    localization.completed,
                    style: TextStyle(
                      color: Color(0xFF8BC34A), // Green Color
                      fontSize: 12,
                    ),
                  ),
                ),
                const Text(
                  '\$40',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
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
