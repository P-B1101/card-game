import 'dart:ui';

import 'package:flutter/material.dart';

import '../../../core/utils/utils.dart';

class BaseDialogWidget extends StatelessWidget {
  final Widget child;
  const BaseDialogWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: Navigator.of(context).pop,
      child: FutureBuilder<bool>(
        initialData: false,
        future: Future.delayed(Duration.zero).then((value) => true),
        builder: (context, snapshot) => AnimatedContainer(
          width: double.infinity,
          height: double.infinity,
          alignment: Alignment.center,
          duration: UiUtils.duration,
          curve: UiUtils.curve,
          color: Colors.black.withOpacity(snapshot.data == true ? .27 : 0),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 32,
                ),
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
