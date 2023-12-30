import 'package:flutter/material.dart';

import '../../utils/assets.dart';

class AdaptiveLoadingWidget extends StatelessWidget {
  final double size;
  final double stroke;
  final Color? color;
  const AdaptiveLoadingWidget({
    super.key,
    this.size = 32,
    this.stroke = 3,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: size,
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: CircularProgressIndicator.adaptive(
          strokeWidth: stroke,
          valueColor: AlwaysStoppedAnimation<Color>(
            color ?? MColors.primaryColor,
          ),
        ),
      ),
    );
  }
}
