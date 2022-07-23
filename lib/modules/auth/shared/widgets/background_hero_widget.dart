import 'package:flutter/material.dart';
import 'package:gbtech_blogging_ds/gbtech_blogging_ds.dart';

class BackgroundHeroWidget extends StatelessWidget {
  final double width;
  final double height;
  final BoxShape shape;
  final bool showIcon;
  final AlignmentGeometry alignment;
  final double padding;
  final double iconSize;
  final Color iconColor;

  const BackgroundHeroWidget({
    Key? key,
    this.shape = BoxShape.circle,
    this.showIcon = true,
    required this.width,
    required this.height,
    this.alignment = Alignment.center,
    this.padding = 0,
    this.iconSize = 48,
    this.iconColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: primaryColor,
        shape: shape,
      ),
      alignment: alignment,
      padding: EdgeInsets.all(padding),
      child: showIcon
          ? Icon(
              Icons.chat,
              size: iconSize,
              color: iconColor,
            )
          : const SizedBox(),
    );
  }
}
