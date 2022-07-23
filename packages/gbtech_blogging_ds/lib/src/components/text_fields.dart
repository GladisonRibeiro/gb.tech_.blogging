import 'package:flutter/material.dart';
import 'package:gbtech_blogging_ds/gbtech_blogging_ds.dart';
import 'package:gbtech_blogging_ds/src/config/constants.dart';

class GbTextField extends StatelessWidget {
  final String? Function(String?)? validator;
  final String? value;
  final Key? keyField;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;

  const GbTextField({
    super.key,
    this.validator,
    this.value,
    this.keyField,
    this.onSaved,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onSaved: onSaved,
      key: keyField,
      initialValue: value,
      validator: validator,
      decoration: const InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          borderSide: BorderSide(color: bodyColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          borderSide: BorderSide(color: bodyColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          borderSide: BorderSide(color: primaryColor, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(borderRadius)),
          borderSide: BorderSide(color: accentColor, width: 2),
        ),
      ),
    );
  }
}
