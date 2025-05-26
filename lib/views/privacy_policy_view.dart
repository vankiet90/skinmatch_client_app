import 'package:flutter/material.dart';
import '../utils/color_utils.dart';
import '../utils/font_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PrivacyPolicyView extends StatelessWidget {
  const PrivacyPolicyView({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: ColorUtils.lightBackgroundSM,
      appBar: AppBar(
        backgroundColor: ColorUtils.lightBackgroundSM,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          localization.privacyPolicy,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontUtils.mediumSM,
            color: ColorUtils.neutral[950],
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionContainer(
              child: Text(
                localization.weValueYourPrivacy,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.5,
                  color: ColorUtils.neutral[900],
                ),
              ),
            ),
            const SizedBox(height: 8),
            _buildSectionContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(localization.whatWeCollect),
                  const SizedBox(height: 8),
                  Text(
                    localization.weCollectYourData,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: ColorUtils.neutral[900],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            _buildSectionContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(localization.howWeUseIt),
                  const SizedBox(height: 8),
                  Text(
                    localization.yourDataHelpsUs,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: ColorUtils.neutral[900],
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildBulletPoint(localization.enhanceYourShoppingExperience),
                  _buildBulletPoint(localization.provideCustomerSupport),
                  _buildBulletPoint(
                      localization.offerPersonalizedSkincareAdvice),
                ],
              ),
            ),
            const SizedBox(height: 8),
            _buildSectionContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(localization.howLongWeStoreIt),
                  const SizedBox(height: 8),
                  Text(
                    localization.weStoreYourData,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: ColorUtils.neutral[900],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            _buildSectionContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(localization.howWeProtectIt),
                  const SizedBox(height: 8),
                  Text(
                    localization.weUseSecureEncryption,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: ColorUtils.neutral[900],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            _buildSectionContainer(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(localization.yourRights),
                  const SizedBox(height: 8),
                  Text(
                    localization.youHaveTheRightTo,
                    style: TextStyle(
                      fontSize: 16,
                      height: 1.5,
                      color: ColorUtils.neutral[900],
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildBulletPoint(localization.reviewOrUpdateData),
                  _buildBulletPoint(localization.requestDeletion),
                  _buildBulletPoint(localization.contactUsForSupport),
                ],
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionContainer({required Widget child}) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: child,
    );
  }

  Widget _buildSectionTitle(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontUtils.semiBoldSM,
        color: ColorUtils.neutral[900],
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '• ',
            style: TextStyle(fontSize: 16, color: ColorUtils.neutral[900]),
          ),
          Expanded(
            child: Text(
              text.substring(2),
              style: TextStyle(
                fontSize: 16,
                height: 1.5,
                color: ColorUtils.neutral[900],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
