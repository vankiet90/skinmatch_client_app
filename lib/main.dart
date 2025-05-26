import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/app_state_provider.dart';
import '../provider/tabbar_provider.dart';
import '../provider/customer_provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../viewmodels/home_view_model.dart';
import '../viewmodels/customer_view_model.dart';
import '../viewmodels/scan_history_view_model.dart';
import '../viewmodels/skincare_plan_view_model.dart';
import '../views/splash_screen.dart';
import '../views/scan_history_view.dart';
import '../views/skincare_plan_views.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppState(),
      child: MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CustomerProvider()),
          ChangeNotifierProvider(create: (_) => TabProvider()),
          ChangeNotifierProvider(create: (_) => HomeViewModel()),
          ChangeNotifierProvider(create: (_) => CustomerViewModel()),
          ChangeNotifierProvider(
            create: (_) => ScanHistoryViewModel()..loadScanData(),
            child: const ScanHistoryView(hasScanned: true),
          ),
          ChangeNotifierProvider(
            create: (_) => SkincarePlanViewModel()..fetchRecommendations(),
            child: const SkincarePlanViews(),
          )
        ],
        child: Consumer<AppState>(
          builder: (context, appState, _) {
            return MaterialApp(
                debugShowCheckedModeBanner: false,
                locale: appState.locale,
                supportedLocales: const [
                  Locale('en'),
                  Locale('vi'),
                ],
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                home: const SplashScreen());
          },
        ),
      ),
    );
  }
}
