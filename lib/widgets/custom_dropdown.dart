import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class CustomDropdown extends StatefulWidget {
  final String? selectedValue;
  final ValueChanged<String?> onChanged;
  final List<String> items;
  final Color iconColor;

  const CustomDropdown({
    super.key,
    required this.selectedValue,
    required this.onChanged,
    required this.items,
    required this.iconColor,
  });

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  List<String> get items => widget.items;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField2<String>(
      value: widget.selectedValue,
      isExpanded: true,
      style: const TextStyle(
        color: Color(0xFF550020),
        fontSize: 16,
      ),
      decoration: InputDecoration(
        contentPadding:
            const EdgeInsets.only(top: 12, bottom: 12, left: 0, right: 12),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.pink.shade100),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.pink.shade100),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: Colors.pink.shade100),
        ),
        filled: true,
        fillColor: Colors.white,
      ),
      items: items.map((item) {
        final isSelected = item == widget.selectedValue;
        return DropdownMenuItem<String>(
          value: item,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 0),
            decoration: BoxDecoration(
              color: isSelected ? Colors.pink.shade50 : Colors.white,
              border: Border(
                bottom: BorderSide(
                  color: Colors.pink.shade100,
                  width: 1,
                ),
              ),
            ),
            child: Text(
              item,
              style: const TextStyle(
                color: Color(0xFF550020),
                fontSize: 16,
              ),
            ),
          ),
        );
      }).toList(),
      selectedItemBuilder: (context) {
        return items.map((item) {
          return Text(
            item,
            style: const TextStyle(
              color: Color(0xFF550020),
              fontSize: 16,
            ),
          );
        }).toList();
      },
      onChanged: (value) {
        widget.onChanged(value);
      },
      iconStyleData: IconStyleData(
        icon: Icon(Icons.keyboard_arrow_down, color: widget.iconColor),
      ),
      dropdownStyleData: DropdownStyleData(
        maxHeight: 250,
        padding: EdgeInsets.zero,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.pink.shade100),
        ),
      ),
    );
  }
}
