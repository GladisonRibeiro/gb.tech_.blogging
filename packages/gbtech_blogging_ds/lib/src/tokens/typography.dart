// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:gbtech_blogging_ds/gbtech_blogging_ds.dart';

const fontFamilySansSerif = 'Noto Sans';
const fontFamilyMonospace = 'Inconsolata';

Text GbHeadline(String text, {TextStyle? style}) => Text(
      text,
      style: const TextStyle(
        fontFamily: fontFamilySansSerif,
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: headlineColor,
      ).merge(style),
    );
Text GbSubTitle(String text, {TextStyle? style}) => Text(
      text,
      style: const TextStyle(
        fontFamily: fontFamilySansSerif,
        fontSize: 24,
        fontWeight: FontWeight.w400,
        color: headlineColor,
      ).merge(style),
    );
Text GbText(String text, {TextStyle? style}) => Text(
      text,
      style: const TextStyle(
        fontFamily: fontFamilyMonospace,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: bodyColor,
      ).merge(style),
    );
Text GbLabel(String text, {TextStyle? style}) => Text(
      text,
      style: const TextStyle(
        fontFamily: fontFamilyMonospace,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: bodyColor,
      ).merge(style),
    );

Text GbButtonLabel(String text, {TextStyle? style}) => Text(
      text,
      style: const TextStyle(
        fontFamily: fontFamilySansSerif,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: buttonLabelColor,
      ).merge(style),
    );