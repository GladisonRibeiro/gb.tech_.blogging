import 'package:flutter/material.dart';
import 'package:gbtech_blogging_ds/gbtech_blogging_ds.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PaddingSmall(
      child: const Center(
        child: CircularProgressIndicator(
          color: secondaryColor,
        ),
      ),
    );
  }
}
