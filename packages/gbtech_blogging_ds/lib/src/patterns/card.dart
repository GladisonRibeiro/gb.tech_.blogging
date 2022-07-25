import 'package:flutter/widgets.dart';
import 'package:gbtech_blogging_ds/gbtech_blogging_ds.dart';

class GbCard extends StatelessWidget {
  final Widget child;
  const GbCard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: surfaceColor,
      ),
      child: PaddingMedium(child: child),
    );
  }
}
