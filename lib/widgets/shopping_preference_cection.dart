import 'package:flutter/material.dart';
import '../utils/color_utils.dart';
import '../utils/font_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ShoppingPreferenceSection extends StatefulWidget {
  const ShoppingPreferenceSection({super.key});

  @override
  State<ShoppingPreferenceSection> createState() =>
      _ShoppingPreferenceSectionState();
}

class _ShoppingPreferenceSectionState extends State<ShoppingPreferenceSection>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  String? _selectedPreference;
  late AnimationController _controller;

  final List<Map<String, String>> _preferences = [
    {
      'title': 'Budget-friendly',
      'description': 'I look for affordable yet effective products'
    },
    {
      'title': 'Mid-range shopper',
      'description': 'I balance quality and price'
    },
    {'title': 'Premium lover', 'description': 'I invest in high-end skincare'},
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorUtils.backgroundSM.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _toggleExpand,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    localization.howDoYouShopForSkincare,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontUtils.mediumSM,
                      color: ColorUtils.neutral[950],
                    ),
                  ),
                ),
                RotationTransition(
                  turns: Tween(begin: 0.0, end: 0.5).animate(_controller),
                  child: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          SizeTransition(
            sizeFactor: _controller,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Padding(
                //   padding: const EdgeInsets.only(top: 8, bottom: 16),
                //   child: Text(
                //     '(Pick the option that best describes you)',
                //     style: TextStyle(
                //       fontSize: 12,
                //       fontWeight: FontUtils.regularSM,
                //       color: ColorUtils.neutral[950],
                //     ),
                //   ),
                // ),
                ..._preferences.map((pref) {
                  final isSelected = _selectedPreference == pref['title'];
                  return GestureDetector(
                    onTap: () {
                      setState(() => _selectedPreference = pref['title']);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: ColorUtils.borderTextField,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorUtils.backgroundSM.shade50,
                              border: Border.all(
                                color: ColorUtils.backgroundSM.shade400,
                                width: 1,
                              ),
                            ),
                            child: isSelected
                                ? Center(
                                    child: Container(
                                      width: 10,
                                      height: 10,
                                      decoration: BoxDecoration(
                                        color: ColorUtils.primaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  )
                                : null,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  pref['title']!,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontUtils.mediumSM,
                                    color: ColorUtils.neutral[950],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  pref['description']!,
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontUtils.regularSM,
                                    color: ColorUtils.neutral[950],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
