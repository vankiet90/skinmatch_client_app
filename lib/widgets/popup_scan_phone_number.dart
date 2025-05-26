import 'package:flutter/material.dart';
import '../utils/color_utils.dart';
import '../utils/font_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';
// import 'package:provider/provider.dart';
// import '../provider/tabbar_provider.dart';
// import '../provider/customer_provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../services/api_scan_service.dart';

class ScanPhoneNumberDialog extends StatefulWidget {
  // final Function(String) onSuccess;

  const ScanPhoneNumberDialog({
    // required this.onSuccess,
    Key? key,
  }) : super(key: key);

  // const ScanPhoneNumberDialog({Key? key}) : super(key: key);

  @override
  _ScanPhoneNumberDialogState createState() => _ScanPhoneNumberDialogState();
}

class _ScanPhoneNumberDialogState extends State<ScanPhoneNumberDialog> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isPhoneValid = false;
  bool _isWelcomeShown = false;

  final ApiScanService apiScanService = ApiScanService();

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_validatePhoneNumber);
  }

  void _validatePhoneNumber() {
    final phone = _phoneController.text.trim();
    final regex = RegExp(r'^(?:\+84|0)(?:3|5|7|8|9)[0-9]{8}$');

    setState(() {
      _isPhoneValid = regex.hasMatch(phone);
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
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
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
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
            SvgPicture.asset(
              'assets/images/ic_logo_popup.svg',
              width: 48,
              height: 48,
            ),
            const SizedBox(height: 32),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                localization.phoneNumber,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontUtils.regularSM,
                  color: ColorUtils.neutral[500],
                ),
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: 'Ex. +84 23 456 7890',
                hintStyle: TextStyle(
                  fontSize: 16,
                  fontWeight: FontUtils.regularSM,
                  color: ColorUtils.neutral[400],
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: ColorUtils.backgroundSM.shade200,
                    width: 1,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: ColorUtils.backgroundSM.shade200,
                    width: 1,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: ColorUtils.backgroundSM.shade200,
                    width: 1,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 12,
                ),
              ),
            ),
            if (_isWelcomeShown) ...[
              const SizedBox(height: 32),
              RichText(
                text: TextSpan(
                  text: localization.welcomeBack,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontUtils.regularSM,
                    color: ColorUtils.neutral[700],
                  ),
                  children: const [
                    TextSpan(
                      text: 'Kiet Vo',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontUtils.semiBoldSM,
                        color: ColorUtils.titleAppbarColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: _isPhoneValid
                    ? () {
                        if (!_isWelcomeShown) {
                          setState(() {
                            _isWelcomeShown = true;
                          });
                        } else {
                          print("scan successfully!");
                        }
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isPhoneValid
                      ? ColorUtils.primaryColor
                      : Colors.grey[400],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  localization.continueText,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontUtils.semiBoldSM,
                    color: Colors.white,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
