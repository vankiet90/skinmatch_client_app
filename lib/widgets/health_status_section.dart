import 'package:flutter/material.dart';
import '../utils/color_utils.dart';
import '../utils/font_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HealthStatusSection extends StatefulWidget {
  const HealthStatusSection({super.key});

  @override
  State<HealthStatusSection> createState() => _HealthStatusSectionState();
}

class _HealthStatusSectionState extends State<HealthStatusSection>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  String? _selectedHealth;
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  final TextEditingController _healthyStatus = TextEditingController();

  final List<String> _healthStatus = [
    'Pregnant or breastfeeding?',
    'Treating any skin conditions?'
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
    _healthyStatus.dispose();
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
                  localization.currentHealthStatus,
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
              children: [
                ..._healthStatus.map((health) {
                  final isSelected = _selectedHealth == health;
                  return Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: SizedBox(
                      height: 48,
                      child: GestureDetector(
                        onTap: () {
                          setState(() => _selectedHealth = health);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: ColorUtils.borderTextField,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.white,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Expanded(
                                child: Text(
                                  health,
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontUtils.regularSM,
                                    color: ColorUtils.neutral[950],
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 50,
                                height: 30,
                                child: FittedBox(
                                  fit: BoxFit.contain,
                                  child: Switch(
                                    value: isSelected,
                                    onChanged: (bool newValue) {
                                      setState(() => _selectedHealth =
                                          newValue ? health : null);
                                    },
                                    activeTrackColor: ColorUtils.primaryColor,
                                    inactiveTrackColor:
                                        ColorUtils.borderTextField,
                                    thumbColor:
                                        WidgetStateProperty.all(Colors.white),
                                    thumbIcon:
                                        WidgetStateProperty.resolveWith<Icon?>(
                                      (Set<WidgetState> states) {
                                        return const Icon(
                                          Icons.circle,
                                          size: 16,
                                          color: Colors.transparent,
                                        );
                                      },
                                    ),
                                    trackOutlineColor:
                                        WidgetStateProperty.resolveWith<Color>(
                                      (Set<WidgetState> states) {
                                        return states
                                                .contains(WidgetState.selected)
                                            ? ColorUtils.primaryColor
                                            : ColorUtils.borderTextField;
                                      },
                                    ),
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 12),
                SizedBox(
                  height: 48,
                  child: TextField(
                    controller: _healthyStatus,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      hintText: localization.pleaseSpecificYourAllergies,
                      hintStyle: const TextStyle(
                        color: ColorUtils.hintTextField,
                        fontSize: 14,
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 12),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
