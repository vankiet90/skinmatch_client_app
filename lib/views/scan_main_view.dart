import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/customer_provider.dart';
import '../views/scan_view.dart';
import '../views/scan_history_view.dart';
import 'package:flutter/cupertino.dart';
import '../utils/color_utils.dart';

class ScanMainView extends StatefulWidget {
  const ScanMainView({Key? key}) : super(key: key);

  @override
  _ScanMainViewState createState() => _ScanMainViewState();
}

class _ScanMainViewState extends State<ScanMainView> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final scanned = Provider.of<CustomerProvider>(context, listen: false);
      if (!scanned.hasScanned && !scanned.isLoading) {
        scanned.reloadHasScanned();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomerProvider>(
      builder: (context, scanned, child) {
        // Debug print
        debugPrint('''
  🔍 CustomerProvider STATE:
    hasScanned: ${scanned.hasScanned}
    isFirstTime: ${scanned.isFirstTime}
    isLoading: ${scanned.isLoading}
    showTabBar: ${scanned.showTabBar}
    isReturningFromHistory: ${scanned.isReturningFromHistory}
  ''');

        WidgetsBinding.instance.addPostFrameCallback((_) {
          final showTabBar = scanned.hasScanned || scanned.isFirstTime;
          if (scanned.showTabBar != showTabBar) {
            scanned.setShowTabBar(showTabBar);
          }
        });

        if (scanned.isLoading) {
          return const Scaffold(
            backgroundColor: ColorUtils.lightBackgroundSM,
            body: Center(
              child: CupertinoActivityIndicator(
                radius: 16,
                color: ColorUtils.primaryColor,
              ),
            ),
          );
        }

        return Scaffold(
          body: scanned.hasScanned || scanned.isFirstTime
              ? ScanHistoryView(
                  hasScanned: scanned.hasScanned,
                )
              : const ScanView(key: ValueKey('scan')),
        );
      },
    );
  }
}
