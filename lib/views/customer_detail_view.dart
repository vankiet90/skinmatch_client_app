import 'package:flutter/material.dart';
import '../models/customer_model.dart';
import '../views/customer_detail_edit_view.dart';
import '../widgets/popup_delete_customer.dart';
import '../widgets/popup_delete_customer_confirm.dart';
import '../views/customer_scan_history_view.dart';
import '../views/purchase_history_view.dart';
import '../utils/color_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CustomerDetailView extends StatelessWidget {
  final CustomerModel customer;

  const CustomerDetailView({super.key, required this.customer});

  final Color mainColor = const Color(0xFFFF5F6D);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: const Color(0xFFFDEFF4),
      appBar: AppBar(
        backgroundColor: ColorUtils.lightBackgroundSM,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          localization.customerDetail,
          style: const TextStyle(
              color: Color(0xFF510D2A), fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          // Avatar & Name
          GestureDetector(
            onTapDown: (TapDownDetails details) {
              _showPopupMenu(context, details.globalPosition);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              padding: const EdgeInsets.symmetric(vertical: 20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage:
                        customer.avatar != null && customer.avatar!.isNotEmpty
                            ? NetworkImage(customer.avatar!)
                            : null,
                    backgroundColor: Colors.grey.shade200,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    customer.name ?? localization.unknown,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      customer.badge ?? '',
                      style: TextStyle(
                        color: customer.badgeTextColor ?? Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const Icon(Icons.more_horiz, color: Colors.grey),
          const SizedBox(height: 6),

          // Info section
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                InfoRow(
                    label: localization.phoneNumber,
                    value: customer.phoneNumber),
                InfoRow(label: 'Email', value: customer.email),
                InfoRow(label: 'DOB', value: customer.dob),
                InfoRow(
                  label: localization.lastVisited,
                  value: customer.lastVisited != null
                      ? '${customer.lastVisited!.day}/${customer.lastVisited!.month}/${customer.lastVisited!.year}'
                      : 'N/A',
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Scan / Purchase history buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) =>
                          CustomerScanHistoryView(customer: customer),
                    ),
                  );
                },
                child: Text(
                  localization.scanHistory,
                  style: TextStyle(
                    color: Colors.pink,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const PurchaseHistoryView(),
                    ),
                  );
                },
                child: Text(
                  localization.purchaseHistory,
                  style: const TextStyle(
                    color: Colors.pink,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),

          const Spacer(),

          // Delete button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFEB4E52),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                minimumSize: const Size.fromHeight(50),
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => DeleteCustomerConfirmDialog(
                    onDeleteConfirmed: () {
                      // action delete
                    },
                  ),
                );
              },
              child: Text(localization.deleteStoreInformation),
            ),
          ),

          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void _showPopupMenu(BuildContext context, Offset position) async {
    final localization = AppLocalizations.of(context)!;
    final selected = await showMenu(
      context: context,
      position: RelativeRect.fromLTRB(
        position.dx,
        position.dy,
        position.dx,
        position.dy,
      ),
      items: [
        PopupMenuItem(
          value: 'edit',
          child: Row(
            children: [
              const Icon(Icons.edit, size: 20),
              const SizedBox(width: 8),
              Text(localization.edit),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'delete',
          child: Row(
            children: [
              const Icon(Icons.delete, size: 20),
              const SizedBox(width: 8),
              Text(localization.delete),
            ],
          ),
        ),
      ],
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.pink.shade100),
      ),
      elevation: 4,
    );

    if (selected == 'edit') {
      // Handle edit
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CustomerEditView(customer: customer),
        ),
      );
    } else if (selected == 'delete') {
      // To show the dialog
      showDialog(
        context: context,
        builder: (context) => DeleteCustomerDialog(
          onDeleteConfirmed: () {
            // action delete
          },
        ),
      );
    }
  }
}

class InfoRow extends StatelessWidget {
  final String label;
  final String? value;

  const InfoRow({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Expanded(
            child: Text(label,
                style: const TextStyle(color: Colors.grey, fontSize: 14)),
          ),
          Text(value ?? 'N/A',
              style:
                  const TextStyle(fontWeight: FontWeight.w500, fontSize: 14)),
        ],
      ),
    );
  }
}
