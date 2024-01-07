import 'package:flutter/material.dart';

import '../../tweens/delay_tween.dart';
import '../../utils/assets.dart';

class BoardLoadingWidget extends StatefulWidget {
  final Color? color;
  const BoardLoadingWidget({
    super.key,
    this.color,
  });

  @override
  State<BoardLoadingWidget> createState() =>
      _BoardLoadingWidgetState();
}

class _BoardLoadingWidgetState extends State<BoardLoadingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final delays = <double>[-.85, -1, -1.15].reversed.toList();
    return SizedBox(
      width: 30,
      height: 30,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (_, __) => Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Align(
              alignment: AlignmentDirectional.centerStart,
              child: Container(
                width: 9,
                height: DelayTween(
                  begin: 9,
                  end: 5,
                  delay: delays[0],
                )
                    .animate(CurvedAnimation(
                      parent: _animationController,
                      curve: Curves.linear,
                    ))
                    .value,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: widget.color ?? MColors.whiteColor,
                    width: 3,
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.center,
              child: Container(
                width: 9,
                height: DelayTween(
                  begin: 9,
                  end: 5,
                  delay: delays[1],
                )
                    .animate(CurvedAnimation(
                      parent: _animationController,
                      curve: Curves.linear,
                    ))
                    .value,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: widget.color ?? MColors.whiteColor,
                    width: 3,
                  ),
                ),
              ),
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: Container(
                width: 9,
                height: DelayTween(
                  begin: 9,
                  end: 5,
                  delay: delays[2],
                )
                    .animate(CurvedAnimation(
                      parent: _animationController,
                      curve: Curves.linear,
                    ))
                    .value,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: widget.color ?? MColors.whiteColor,
                    width: 3,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}