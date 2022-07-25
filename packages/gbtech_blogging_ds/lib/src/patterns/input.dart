import 'package:flutter/material.dart';

import '../components/components.dart';
import '../tokens/tokens.dart';

class GbInput extends StatelessWidget {
  final Key? keyInput;
  final String label;
  final String? Function(String?)? validator;
  final String? value;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;
  final int? maxLines;
  final TextInputType? keyboardType;
  final int? maxLength;
  final TextInputAction? textInputAction;

  const GbInput({
    Key? key,
    required this.label,
    this.validator,
    this.value,
    this.keyInput,
    this.onSaved,
    this.controller,
    this.maxLines = 1,
    this.keyboardType,
    this.maxLength,
    this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GbLabel(label),
        SpacerSmall(),
        GbTextField(
          keyField: keyInput,
          validator: validator,
          onSaved: onSaved,
          controller: controller,
          maxLines: maxLines,
          maxLength: maxLength,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
        ),
      ],
    );
  }
}

class GbPasswordInput extends StatelessWidget {
  final Key? keyInput;
  final String label;
  final String? Function(String?)? validator;
  final String? value;
  final void Function(String?)? onSaved;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;

  const GbPasswordInput({
    Key? key,
    required this.label,
    this.validator,
    this.value,
    this.keyInput,
    this.onSaved,
    this.controller,
    this.textInputAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GbLabel(label),
        SpacerSmall(),
        GbPasswordField(
          keyField: keyInput,
          validator: validator,
          onSaved: onSaved,
          controller: controller,
          textInputAction: textInputAction,
        ),
      ],
    );
  }
}
