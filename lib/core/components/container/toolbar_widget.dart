import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';

import '../../utils/assets.dart';
import '../../utils/utils.dart';

class ToolbarWidget extends StatelessWidget {
  final Widget child;
  const ToolbarWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: MColors.secondaryColor,
      child: Stack(
        children: [
          Positioned.fill(
            top: 42,
            child: child,
          ),
          Row(
            children: [
              SizedBox.square(
                dimension: 42,
                child: Material(
                  color: Colors.black.withOpacity(.1),
                  child: const InkWell(
                    onTap: Utils.exitApp,
                    child: Center(
                      child: Icon(
                        Icons.close,
                        size: 20,
                        color: MColors.whiteColor,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: MouseRegion(
                  cursor: SystemMouseCursors.move,
                  child: GestureDetector(
                    onPanStart: (details) => appWindow.startDragging(),
                    child: Container(
                      height: 42,
                      width: double.infinity,
                      color: Colors.black.withOpacity(.1),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
