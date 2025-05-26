import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../utils/color_utils.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTabBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  final VoidCallback onScanTap;

  const CustomTabBar({
    Key? key,
    required this.currentIndex,
    required this.onTap,
    required this.onScanTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    final screenWidth = MediaQuery.of(context).size.width;

    return SizedBox(
      height: 80,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          BottomNavigationBar(
            currentIndex: currentIndex,
            onTap: (index) => onTap(index),
            backgroundColor: Colors.white,
            selectedItemColor: ColorUtils.primaryColor,
            unselectedItemColor: ColorUtils.primaryColor,
            selectedLabelStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            unselectedLabelStyle:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/ic_home.svg',
                  width: 24,
                  height: 24,
                ),
                activeIcon: SvgPicture.asset(
                  'assets/images/ic_home_active.svg',
                  width: 24,
                  height: 24,
                ),
                label: localization.menuHome,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/ic_customer.svg',
                  width: 24,
                  height: 24,
                ),
                activeIcon: SvgPicture.asset(
                  'assets/images/ic_customer_active.svg',
                  width: 24,
                  height: 24,
                ),
                label: localization.menuCustomer,
              ),
              BottomNavigationBarItem(
                icon: const SizedBox(height: 0), // blank
                label: '',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/ic_inventory.svg',
                  width: 24,
                  height: 24,
                ),
                activeIcon: SvgPicture.asset(
                  'assets/images/ic_inventory_active.svg',
                  width: 24,
                  height: 24,
                ),
                label: localization.menuInventory,
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  'assets/images/ic_marketing.svg',
                  width: 24,
                  height: 24,
                ),
                activeIcon: SvgPicture.asset(
                  'assets/images/ic_marketing_active.svg',
                  width: 24,
                  height: 24,
                ),
                label: localization.menuMarketing,
              ),
            ],
          ),
          Positioned(
            top: -18,
            left: screenWidth / 2 - 28,
            child: GestureDetector(
              onTap: onScanTap,
              child: Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFF92772),
                      Color(0xFFFB497A),
                      Color(0xFFFE6E82),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: SvgPicture.asset(
                  'assets/images/ic_scan.svg',
                  width: 14,
                  height: 14,
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
