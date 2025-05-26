import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../utils/color_utils.dart';

class MarketingView extends StatefulWidget {
  const MarketingView({Key? key}) : super(key: key);

  @override
  State<MarketingView> createState() => _MarketingViewState();
}

class _MarketingViewState extends State<MarketingView> {
  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return Scaffold(
      backgroundColor: ColorUtils.lightBackgroundSM,
      body: Center(
        child: Text(localization.comingSoon),
      ),
    );
  }
}
