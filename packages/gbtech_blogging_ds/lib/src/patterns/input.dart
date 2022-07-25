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
  final String? semanticsLabel;

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
    this.semanticsLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticsLabel,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GbLabel(label),
          SpacerSmall(),
          Container(
            color: surfaceColor,
            child: GbTextField(
              keyField: keyInput,
              validator: validator,
              onSaved: onSaved,
              controller: controller,
              maxLines: maxLines,
              maxLength: maxLength,
              keyboardType: keyboardType,
              textInputAction: textInputAction,
            ),
          ),
        ],
      ),
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
  final String? semanticsLabel;

  const GbPasswordInput({
    Key? key,
    required this.label,
    this.validator,
    this.value,
    this.keyInput,
    this.onSaved,
    this.controller,
    this.textInputAction,
    this.semanticsLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticsLabel,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GbLabel(label),
          SpacerSmall(),
          Container(
            color: surfaceColor,
            child: GbPasswordField(
              keyField: keyInput,
              validator: validator,
              onSaved: onSaved,
              controller: controller,
              textInputAction: textInputAction,
            ),
          ),
        ],
      ),
    );
  }
}
