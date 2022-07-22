// ignore_for_file: non_constant_identifier_names

import 'package:flutter/widgets.dart';

import '../config/constants.dart';

extension Spacing on SizedBox {
  SizedBox spacing({int size = 1, base = baseSpacing}) {
    return SizedBox(
      height: base * size,
      width: base * size,
    );
  }
}

SizedBox SpacerSmall() => const SizedBox().spacing(size: 1);
SizedBox SpacerMedium() => const SizedBox().spacing(size: 2);
SizedBox SpacerLarge() => const SizedBox().spacing(size: 3);
SizedBox SpacerExtraLarge() => const SizedBox().spacing(size: 4);

Padding PaddingSmall({required Widget child}) => Padding(
      padding: const EdgeInsets.all(baseSpacing * 1),
      child: child,
    );
Padding PaddingMedium({required Widget child}) => Padding(
      padding: const EdgeInsets.all(baseSpacing * 2),
      child: child,
    );
Padding PaddingLarge({required Widget child}) => Padding(
      padding: const EdgeInsets.all(baseSpacing * 3),
      child: child,
    );
Padding PaddingExtraLarge({required Widget child}) => Padding(
      padding: const EdgeInsets.all(baseSpacing * 4),
      child: child,
    );
