import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_tab_bar.dart';
import '../provider/tabbar_provider.dart';
import '../views/home_view.dart';
import '../views/customer_view.dart';
import '../views/inventory_view.dart';
import '../views/marketing_view.dart';
import '../views/scan_main_view.dart';
import '../provider/customer_provider.dart';

class MainTabView extends StatefulWidget {
  const MainTabView({super.key});

  @override
  State<MainTabView> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<MainTabView> {
  final List<Widget> _views = const [
    HomeView(),
    CustomerView(),
    ScanMainView(),
    InventoryView(),
    MarketingView(),
  ];

  @override
  @override
  Widget build(BuildContext context) {
    final tabProvider = Provider.of<TabProvider>(context);
    final showTabBar = Provider.of<CustomerProvider>(context).showTabBar;

    return Scaffold(
      backgroundColor: Colors.white,
      body: _views[tabProvider.currentIndex],
      bottomNavigationBar: showTabBar
          ? CustomTabBar(
              currentIndex: tabProvider.currentIndex,
              onTap: (index) => tabProvider.setTab(index),
              onScanTap: () => tabProvider.setTab(2),
            )
          : null,
    );
  }
}
