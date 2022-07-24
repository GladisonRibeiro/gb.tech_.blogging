import 'package:flutter/material.dart';
import 'package:gbtech_blogging_ds/src/config/constants.dart';

import '../tokens/tokens.dart';

class GbButton extends StatelessWidget {
  final void Function()? onTap;
  final String label;
  const GbButton({Key? key, this.onTap, required this.label}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: onTap != null
              ? buttonBackgroundColor
              : buttonBackgroundColor.withOpacity(0.3),
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        width: double.infinity,
        height: buttonMinHeight,
        child: GbButtonLabel(label),
      ),
    );
  }
}

class GbTextButton extends StatelessWidget {
  final void Function()? onTap;
  final String label;
  const GbTextButton({Key? key, this.onTap, required this.label})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        color: Colors.transparent,
        alignment: Alignment.center,
        width: double.infinity,
        height: buttonMinHeight,
        child: GbButtonLabel(
          label,
          style: const TextStyle(
            color: buttonBackgroundColor,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
    );
  }
}
