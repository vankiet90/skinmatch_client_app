import 'package:flutter/material.dart';
import '../utils/color_utils.dart';
import '../utils/font_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BirthdaySection extends StatefulWidget {
  const BirthdaySection({Key? key}) : super(key: key);

  @override
  _BirthdaySectionState createState() => _BirthdaySectionState();
}

class _BirthdaySectionState extends State<BirthdaySection>
    with SingleTickerProviderStateMixin {
  final TextEditingController _birthdayController = TextEditingController();
  DateTime? _selectedDate;
  late AnimationController _controller;
  late Animation<double> _rotationAnimation;
  late Animation<double> _heightAnimation;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: ColorUtils.primaryColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            dialogBackgroundColor: Colors.white,
          ),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _birthdayController.text =
            "${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _rotationAnimation = Tween<double>(begin: 0, end: 0.5).animate(_controller);
    _heightAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _birthdayController.dispose();
    super.dispose();
  }

  void _toggleExpand() {
    if (_controller.isCompleted) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: ColorUtils.backgroundSM.shade50,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: GestureDetector(
                onTap: _toggleExpand,
                behavior: HitTestBehavior.opaque,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      localization.dateOfBirth,
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
            ),
            AnimatedBuilder(
              animation: _heightAnimation,
              builder: (context, child) {
                return ClipRect(
                  child: Align(
                    heightFactor: _heightAnimation.value,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                        bottom: 16,
                      ),
                      child: child,
                    ),
                  ),
                );
              },
              child: TextFormField(
                controller: _birthdayController,
                readOnly: true,
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: 'Ex: 12/12/1999',
                  hintStyle: const TextStyle(
                    color: ColorUtils.hintTextField,
                    fontSize: 14,
                  ),
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
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_month_outlined),
                    onPressed: () => _selectDate(context),
                    color: ColorUtils.neutral[900],
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 16,
                  ),
                ),
                onTap: () => _selectDate(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
