import 'package:flutter/material.dart';
import 'popup_confirm_password.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DeleteCustomerConfirmDialog extends StatefulWidget {
  final Function() onDeleteConfirmed;

  const DeleteCustomerConfirmDialog({
    required this.onDeleteConfirmed,
    Key? key,
  }) : super(key: key);

  @override
  _DeleteCustomerConfirmDialogState createState() =>
      _DeleteCustomerConfirmDialogState();
}

class _DeleteCustomerConfirmDialogState
    extends State<DeleteCustomerConfirmDialog> {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            Text(
              localization.confirmDelete,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),

            // Description
            Text(
              localization.personalDataDeletionRequested,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16.0,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 24),

            // Action Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    localization.cancel,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);

                    Future.delayed(Duration.zero, () {
                      showDialog(
                        context: context,
                        builder: (context) => DeleteConfirmationDialog(
                          customerName: localization.customerName,
                          onConfirmDelete: () {
                            widget.onDeleteConfirmed();
                            Navigator.pop(context);
                          },
                        ),
                      );
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 12),
                  ),
                  child: Text(
                    localization.delete,
                    style: TextStyle(fontSize: 14, color: Colors.white),
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
