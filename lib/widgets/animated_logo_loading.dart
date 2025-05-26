import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../utils/font_utils.dart';
import '../utils/color_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoadingScreen extends StatefulWidget {
  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              'assets/images/meta_ai_logo.json',
              controller: _controller,
              onLoaded: (composition) {
                _controller
                  ..duration = composition.duration
                  ..repeat();
              },
              width: 200,
              height: 200,
              delegates: LottieDelegates(
                values: [
                  // Đây là cách mạnh mẽ nhất để áp dụng cho tất cả Fill 1
                  ValueDelegate.color(
                    const ['**', 'Fill 1'],
                    value: ColorUtils.primaryColor,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            RichText(
              text: TextSpan(
                children: [
                  const TextSpan(
                    text: 'AI ',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: ColorUtils.primaryColor,
                      fontSize: 24,
                    ),
                  ),
                  TextSpan(
                    text: localization.analyzingFacialSkinCondition,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontUtils.semiBoldSM,
                      color: ColorUtils.neutral[950],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
