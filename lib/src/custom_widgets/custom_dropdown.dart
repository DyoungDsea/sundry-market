import 'package:flutter/material.dart';

class CustomDropdownMenu extends StatefulWidget {
  const CustomDropdownMenu({
    Key? key,
    required this.items,
    this.selectedValue,
    required this.hint,
    this.validator,
    this.onChanged,
    this.onSaved,
  }) : super(key: key);

  final List<Map<String, dynamic>> items;
  final String? selectedValue;
  final String hint;
  final String? Function(String?)? validator;
  final void Function(String?)? onChanged;
  final void Function(String?)? onSaved;

  @override
  State<CustomDropdownMenu> createState() => _CustomDropdownMenuState();
}

class _CustomDropdownMenuState extends State<CustomDropdownMenu> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: DropdownButtonFormField<String>(
        isExpanded: true,
        isDense: false,
        itemHeight: 60,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 10,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          hintText: widget.hint,
        ),
        items: widget.items
            .map((item) => DropdownMenuItem<String>(
                  value: item['value'].toString(),
                  child: Text(
                    item['label'].toString(),
                    style: const TextStyle(
                      fontSize: 14,
                    ),
                  ),
                ))
            .toList(),
        value: widget.selectedValue,
        validator: widget.validator,
        onChanged: widget.onChanged,
        onSaved: widget.onSaved,
        icon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.black45,
        ),
        iconSize: 24,
      ),
    );
  }
}
