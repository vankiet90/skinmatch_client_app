import 'package:flutter/material.dart';
import '../utils/color_utils.dart';
import '../utils/font_utils.dart';
import '../widgets/custom_dropdown.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AllergiesSection extends StatefulWidget {
  const AllergiesSection({super.key});

  @override
  State<AllergiesSection> createState() => _AllergiesSectionState();
}

class _AllergiesSectionState extends State<AllergiesSection>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  String? _selectedAllergy = 'Paraben';
  final TextEditingController _allergyDetailController =
      TextEditingController();
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;

  final List<String> _allergies = [
    'Paraben',
    'Fragrance',
    'Alcohol',
    'Other',
  ];

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
    _allergyDetailController.dispose();
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
    final List<String> translatedAllergies = _allergies.map((allergy) {
      switch (allergy) {
        case 'paraben':
          return localization.paraben;
        case 'fragrance':
          return localization.fragrance;
        case 'alcohol':
          return localization.alcohol;
        case 'other':
          return localization.other;
        default:
          return allergy;
      }
    }).toList();
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorUtils.backgroundSM.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: _toggleExpand,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  localization.doYouHaveAnyAllergies,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                CustomDropdown(
                  selectedValue: _selectedAllergy,
                  onChanged: (value) {
                    setState(() {
                      _selectedAllergy = value;
                    });
                  },
                  items: translatedAllergies,
                  iconColor: ColorUtils.neutral[900]!,
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _allergyDetailController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: localization.pleaseSpecificYourAllergies,
                    hintStyle: const TextStyle(
                      color: ColorUtils.hintTextField,
                      fontSize: 14,
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 12),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: ColorUtils.borderTextField,
                        width: 1,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: ColorUtils.borderTextField,
                        width: 1,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: const BorderSide(
                        color: ColorUtils.borderTextField,
                        width: 1,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
