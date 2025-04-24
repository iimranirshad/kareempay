import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class DropdownTextField extends StatefulWidget {
  final String label;
  final List<String> dropdownItems;
  final String initialValue;
  final TextEditingController controller;
  final ValueChanged<String> onDropdownChanged;

  const DropdownTextField({
    super.key,
    required this.label,
    required this.dropdownItems,
    required this.initialValue,
    required this.controller,
    required this.onDropdownChanged,
  });

  @override
  State<DropdownTextField> createState() => _DropdownTextFieldState();
}

class _DropdownTextFieldState extends State<DropdownTextField> {
  late String _selectedValue;

  @override
  void initState() {
    super.initState();

    // Validate: if initialValue is not in the list, pick first item safely
    _selectedValue = widget.dropdownItems.contains(widget.initialValue)
        ? widget.initialValue
        : widget.dropdownItems.first;

    // Update the controller’s text accordingly
    widget.controller.text = _selectedValue;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.h),
      child: TextFormField(
        controller: widget.controller,
        textAlign: TextAlign.start,
        textInputAction: TextInputAction.none,
        readOnly: true,  // prevent manual typing — dropdown only
        style: GoogleFonts.poppins(fontSize: 18.sp),
        decoration: InputDecoration(
          fillColor: const Color(0xffD3D3D3),
          filled: true,
          label: Text(widget.label),
          labelStyle: GoogleFonts.poppins(fontSize: 16.sp, color: Colors.grey),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          suffixIcon: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedValue,
              icon: const Icon(Icons.arrow_drop_down, color: Colors.grey),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedValue = newValue;
                  });
                  widget.controller.text = newValue;
                  widget.onDropdownChanged(newValue);
                }
              },
              items: widget.dropdownItems.toSet().map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: GoogleFonts.poppins(fontSize: 16.sp, color: Colors.black),
                  ),
                );
              }).toList(),
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(2.h),
          ),
        ),
      ),
    );
  }
}
