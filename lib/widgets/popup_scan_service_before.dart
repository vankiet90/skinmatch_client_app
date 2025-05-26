import 'package:flutter/material.dart';
import '../utils/color_utils.dart';
import '../utils/font_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import '../provider/customer_provider.dart';
import '../widgets/popup_scan_phone_number.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScanBeforeDialog extends StatefulWidget {
  final Function(String) onOptionSelected;
  final Function(String) onSuccess;
  final String? initialOption;

  const ScanBeforeDialog({
    required this.onOptionSelected,
    required this.onSuccess,
    this.initialOption,
    Key? key,
  }) : super(key: key);

  @override
  _ScanBeforeDialogState createState() => _ScanBeforeDialogState();
}

class _ScanBeforeDialogState extends State<ScanBeforeDialog> {
  void _showScanPhoneNumberDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return const ScanPhoneNumberDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: ColorUtils.backgroundSM.shade200,
            width: 1,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: SvgPicture.asset(
                'assets/images/ic_logo_popup.svg',
                width: 40,
                height: 40,
              ),
            ),
            Text(
              localization.haveYouEverUsedOurServiceBefore,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontUtils.mediumSM,
                color: ColorUtils.neutral[950],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                  onPressed: () {
                    widget.onSuccess(localization.alreadyScanBefore);
                    Navigator.pop(context);

                    Future.delayed(Duration.zero, () {
                      _showScanPhoneNumberDialog();
                    });
                  },
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    alignment: Alignment.center,
                  ),
                  child: Text(
                    localization.alreadyScanBefore,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontUtils.semiBoldSM,
                      color: ColorUtils.neutral[900],
                    ),
                  ),
                ),
                SizedBox(
                  width: 117,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onOptionSelected(localization.no);

                      Navigator.pop(context);
                      Provider.of<CustomerProvider>(context, listen: false)
                          .setIsFirstTime(true);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorUtils.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    child: Text(
                      localization.no,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontUtils.semiBoldSM,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
