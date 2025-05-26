import 'package:flutter/material.dart';
import '../utils/color_utils.dart';
import '../utils/font_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SkinTypeAndAllergiesSection extends StatefulWidget {
  const SkinTypeAndAllergiesSection({super.key});

  @override
  State<SkinTypeAndAllergiesSection> createState() =>
      _SkinTypeAndAllergiesSectionState();
}

class _SkinTypeAndAllergiesSectionState
    extends State<SkinTypeAndAllergiesSection>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  String? _selectedGender;
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  final List<String> _genders = ['Oily', 'Combination', 'Sensitive', 'Other'];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(begin: 0, end: 0.5).animate(_controller);
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  localization.skinType,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontUtils.mediumSM,
                    color: ColorUtils.neutral[950],
                  ),
                ),
                RotationTransition(
                  turns: _rotationAnimation,
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
            axisAlignment: -1.0,
            child: Column(
              children: _genders.map((gender) {
                final isSelected = _selectedGender == gender;
                return Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: GestureDetector(
                    onTap: () {
                      setState(() => _selectedGender = gender);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 14, horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSelected
                              ? ColorUtils.primaryColor
                              : ColorUtils.borderTextField,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: ColorUtils.backgroundSM.shade50,
                              border: Border.all(
                                color: isSelected
                                    ? ColorUtils.primaryColor
                                    : ColorUtils.backgroundSM.shade400,
                                width: 1,
                              ),
                            ),
                            child: isSelected
                                ? Center(
                                    child: Container(
                                      width: 12,
                                      height: 12,
                                      decoration: BoxDecoration(
                                        color: ColorUtils.primaryColor,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                  )
                                : null,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            gender,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontUtils.regularSM,
                              color: ColorUtils.neutral[950],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
