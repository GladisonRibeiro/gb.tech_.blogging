import 'package:flutter/widgets.dart';

import '../components/components.dart';
import '../tokens/tokens.dart';

class GbInput extends StatelessWidget {
  final Key? keyInput;
  final String label;
  final String? Function(String?)? validator;
  final String? value;

  const GbInput({
    Key? key,
    required this.label,
    this.validator,
    this.value,
    this.keyInput,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GbLabel(label),
        SpacerSmall(),
        GbTextField(keyField: keyInput, validator: validator),
      ],
    );
  }
}