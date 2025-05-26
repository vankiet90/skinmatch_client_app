import 'package:flutter/material.dart';
import '../utils/font_utils.dart';
import '../widgets/custom_dropdown.dart';
import '../utils/color_utils.dart';
import 'package:flutter/gestures.dart';
import '../views/privacy_policy_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PolicyAgreementSection extends StatefulWidget {
  const PolicyAgreementSection({Key? key}) : super(key: key);

  @override
  State<PolicyAgreementSection> createState() => _PolicyAgreementSectionState();
}

class _PolicyAgreementSectionState extends State<PolicyAgreementSection> {
  bool isChecked = false;
  String? selectedOption = 'Store for 6 months';

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Container(
      margin: EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: ColorUtils.backgroundSM.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localization.policyAgreement,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontUtils.mediumSM,
              color: ColorUtils.neutral[950],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            localization.personalDataCollected,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontUtils.regularSM,
              color: ColorUtils.neutral[950],
            ),
          ),
          const SizedBox(height: 16),
          CustomDropdown(
            selectedValue: selectedOption,
            onChanged: (value) {
              setState(() {
                selectedOption = value;
              });
            },
            items: [
              localization.storeForSixMonths,
              localization.storeForOneMonths,
              localization.storeForTwoMonths,
              localization.doNotStoreMyInformation,
            ],
            iconColor: ColorUtils.primaryColor,
          ),
          const SizedBox(height: 24),
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              setState(() {
                isChecked = !isChecked;
              });
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  margin: const EdgeInsets.only(right: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: isChecked
                        ? ColorUtils.backgroundSM.shade400
                        : ColorUtils.backgroundSM.shade50,
                    border: Border.all(
                      color: ColorUtils.backgroundSM.shade400,
                      width: 1,
                    ),
                  ),
                  child: isChecked
                      ? const Icon(
                          Icons.check,
                          size: 18,
                          color: Colors.white,
                        )
                      : null,
                ),
                Expanded(
                  child: RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                      children: [
                        TextSpan(
                          text: localization.iAgreeToStoreMyPersonalInformation,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontUtils.regularSM,
                            color: ColorUtils.neutral[950],
                          ),
                        ),
                        TextSpan(
                          text: localization.privacyPolicy,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontUtils.regularSM,
                            decoration: TextDecoration.underline,
                            color: ColorUtils.neutral[950],
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PrivacyPolicyView(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
