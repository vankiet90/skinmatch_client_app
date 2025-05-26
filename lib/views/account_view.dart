import 'package:flutter/material.dart';
import '../utils/color_utils.dart';
import '../views/translate_language_view.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AccountView extends StatelessWidget {
  const AccountView({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: ColorUtils.lightBackgroundSM,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          localization.account,
          style: const TextStyle(
              color: Colors.black, fontSize: 20, fontWeight: FontWeight.w500),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _buildAccountOption(
              context,
              localization.profile,
              () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileScreen()));
              },
            ),
            _buildAccountOption(
              context,
              localization.signInSecurity,
              () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SignInSecurityScreen()));
              },
            ),
            _buildAccountOption(
              context,
              localization.language,
              () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => TranslateLanguageView()));
              },
            ),
            _buildAccountOption(
              context,
              localization.privacy,
              () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const PrivacyScreen()));
              },
            ),
            _buildAccountOption(
              context,
              localization.staffManagement,
              () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const StaffManagementScreen()));
              },
            ),
            const SizedBox(height: 16),
            _buildAccountOption(
              context,
              localization.feedback,
              () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FeedbackScreen()));
              },
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFE57373),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  localization.logout,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w500),
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.phone, color: Colors.grey, size: 16),
                const SizedBox(width: 8),
                Text(
                  localization.support,
                  style: TextStyle(color: Colors.grey.shade700, fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAccountOption(
      BuildContext context, String title, void Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Colors.grey, width: 0.5),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16),
            ),
            const Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 16),
          ],
        ),
      ),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(localization.profile)),
      body: Center(child: Text(localization.profileScreen)),
    );
  }
}

class SignInSecurityScreen extends StatelessWidget {
  const SignInSecurityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(localization.signInSecurity)),
      body: Center(child: Text(localization.signInSecurityScreen)),
    );
  }
}

class LanguageScreen extends StatelessWidget {
  const LanguageScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(localization.language)),
      body: Center(child: Text(localization.languageScreen)),
    );
  }
}

class PrivacyScreen extends StatelessWidget {
  const PrivacyScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(localization.privacy)),
      body: Center(child: Text(localization.privacyScreen)),
    );
  }
}

class StaffManagementScreen extends StatelessWidget {
  const StaffManagementScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(localization.staffManagement)),
      body: Center(child: Text(localization.staffManagementScreen)),
    );
  }
}

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(localization.feedback)),
      body: Center(child: Text(localization.feedbackScreen)),
    );
  }
}
