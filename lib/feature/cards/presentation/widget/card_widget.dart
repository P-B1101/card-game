import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/utils/assets.dart';
import '../../../../core/utils/enum.dart';
import '../../../../core/utils/utils.dart';
import '../../domain/entity/card.dart';

class CardWidget extends StatelessWidget {
  final CardType type;
  final CardName name;
  final bool isVisible;
  final bool hasShadow;
  final bool hasAnimation;
  const CardWidget({
    super.key,
    required this.name,
    required this.type,
    required this.isVisible,
    this.hasShadow = true,
    this.hasAnimation = false,
  });

  factory CardWidget.front(MCard card) => CardWidget(
        name: card.name,
        type: card.type,
        isVisible: true,
        hasAnimation: false,
      );

  factory CardWidget.back(MCard card) => CardWidget(
        name: card.name,
        type: card.type,
        isVisible: false,
        hasAnimation: false,
      );

  @override
  Widget build(BuildContext context) {
    return hasAnimation
        ? TweenAnimationBuilder<double>(
            duration: UiUtils.duration,
            curve: UiUtils.curve,
            tween: Tween(begin: isVisible ? pi : 0, end: isVisible ? 0 : pi),
            builder: (context, value, child) => Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(value),
              alignment: FractionalOffset.center,
              child: child,
            ),
            child: _mainBody,
          )
        : _mainBody;
  }

  Widget get _mainBody => Builder(
        builder: (context) => SizedBox(
          width: 110,
          child: AspectRatio(
            aspectRatio: .71,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: MColors.whiteColor,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 0),
                    blurRadius: 7,
                    color: Colors.black.withOpacity(.2),
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: AnimatedSwitcher(
                duration: UiUtils.duration * .5,
                switchInCurve: Curves.easeIn,
                switchOutCurve: Curves.easeOut,
                child: isVisible ? _body : _backBody,
              ),
            ),
          ),
        ),
      );

  Widget get _backBody => Builder(
        key: const ValueKey(0),
        builder: (context) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: const Color(0xFFFb0F0C),
              width: 2,
            ),
          ),
          padding: const EdgeInsetsDirectional.only(
            start: 10,
            bottom: 5,
            end: 5,
            top: 0,
          ),
          margin: const EdgeInsets.all(4),
          child: SvgPicture.asset(
            'assets/images/svg/back.svg',
            fit: BoxFit.cover,
            clipBehavior: Clip.none,
          ),
        ),
      );

  Widget get _body => Builder(
        key: const ValueKey(1),
        builder: (context) => Stack(
          fit: StackFit.expand,
          children: [
            Align(
              alignment: const AlignmentDirectional(1, -1),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                child: Column(
                  children: [
                    Text(
                      name.value,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: Fonts.medium600,
                        fontFamily: '',
                        color: type.color,
                      ),
                    ),
                    Transform.translate(
                      offset: const Offset(0, -12),
                      child: Text(
                        type.value,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: Fonts.medium600,
                          fontFamily: '',
                          color: type.color,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: const AlignmentDirectional(-1, 1),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                ),
                child: RotatedBox(
                  quarterTurns: 2,
                  child: Column(
                    children: [
                      Text(
                        name.value,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: Fonts.medium600,
                          fontFamily: '',
                          color: type.color,
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(0, -12),
                        child: Text(
                          type.value,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: Fonts.medium600,
                            fontFamily: '',
                            color: type.color,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            _CenterWidget(name: name, type: type),
          ],
        ),
      );
}

class _CenterWidget extends StatelessWidget {
  final CardType type;
  final CardName name;
  const _CenterWidget({
    required this.name,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 25),
      child: Center(
        child: switch (name) {
          CardName.ace => Text(
              type.value,
              style: TextStyle(
                fontSize: 32,
                fontWeight: Fonts.medium600,
                fontFamily: '',
                color: type.color,
              ),
            ),
          CardName.two => Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  type.value,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: Fonts.medium600,
                    fontFamily: '',
                    color: type.color,
                  ),
                ),
                Text(
                  type.value,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: Fonts.medium600,
                    fontFamily: '',
                    color: type.color,
                  ),
                ),
              ],
            ),
          CardName.three => Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  type.value,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: Fonts.medium600,
                    fontFamily: '',
                    color: type.color,
                  ),
                ),
                Text(
                  type.value,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: Fonts.medium600,
                    fontFamily: '',
                    color: type.color,
                  ),
                ),
                RotatedBox(
                  quarterTurns: 2,
                  child: Text(
                    type.value,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: Fonts.medium600,
                      fontFamily: '',
                      color: type.color,
                    ),
                  ),
                ),
              ],
            ),
          CardName.four => Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      type.value,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: Fonts.medium600,
                        fontFamily: '',
                        color: type.color,
                      ),
                    ),
                    Text(
                      type.value,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: Fonts.medium600,
                        fontFamily: '',
                        color: type.color,
                      ),
                    ),
                  ],
                ),
                RotatedBox(
                  quarterTurns: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        type.value,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: Fonts.medium600,
                          fontFamily: '',
                          color: type.color,
                        ),
                      ),
                      Text(
                        type.value,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: Fonts.medium600,
                          fontFamily: '',
                          color: type.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          CardName.five => Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      type.value,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: Fonts.medium600,
                        fontFamily: '',
                        color: type.color,
                      ),
                    ),
                    Text(
                      type.value,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: Fonts.medium600,
                        fontFamily: '',
                        color: type.color,
                      ),
                    ),
                  ],
                ),
                Text(
                  type.value,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: Fonts.medium600,
                    fontFamily: '',
                    color: type.color,
                  ),
                ),
                RotatedBox(
                  quarterTurns: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        type.value,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: Fonts.medium600,
                          fontFamily: '',
                          color: type.color,
                        ),
                      ),
                      Text(
                        type.value,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: Fonts.medium600,
                          fontFamily: '',
                          color: type.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          CardName.six => Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      type.value,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: Fonts.medium600,
                        fontFamily: '',
                        color: type.color,
                      ),
                    ),
                    Text(
                      type.value,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: Fonts.medium600,
                        fontFamily: '',
                        color: type.color,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      type.value,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: Fonts.medium600,
                        fontFamily: '',
                        color: type.color,
                      ),
                    ),
                    Text(
                      type.value,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: Fonts.medium600,
                        fontFamily: '',
                        color: type.color,
                      ),
                    ),
                  ],
                ),
                RotatedBox(
                  quarterTurns: 2,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        type.value,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: Fonts.medium600,
                          fontFamily: '',
                          color: type.color,
                        ),
                      ),
                      Text(
                        type.value,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: Fonts.medium600,
                          fontFamily: '',
                          color: type.color,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          CardName.seven => Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          type.value,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: Fonts.medium600,
                            fontFamily: '',
                            color: type.color,
                          ),
                        ),
                        Text(
                          type.value,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: Fonts.medium600,
                            fontFamily: '',
                            color: type.color,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          type.value,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: Fonts.medium600,
                            fontFamily: '',
                            color: type.color,
                          ),
                        ),
                        Text(
                          type.value,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: Fonts.medium600,
                            fontFamily: '',
                            color: type.color,
                          ),
                        ),
                      ],
                    ),
                    RotatedBox(
                      quarterTurns: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            type.value,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: Fonts.medium600,
                              fontFamily: '',
                              color: type.color,
                            ),
                          ),
                          Text(
                            type.value,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: Fonts.medium600,
                              fontFamily: '',
                              color: type.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: const AlignmentDirectional(0, -.5),
                  child: Text(
                    type.value,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: Fonts.medium600,
                      fontFamily: '',
                      color: type.color,
                    ),
                  ),
                ),
              ],
            ),
          CardName.eight => Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          type.value,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: Fonts.medium600,
                            fontFamily: '',
                            color: type.color,
                          ),
                        ),
                        Text(
                          type.value,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: Fonts.medium600,
                            fontFamily: '',
                            color: type.color,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          type.value,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: Fonts.medium600,
                            fontFamily: '',
                            color: type.color,
                          ),
                        ),
                        Text(
                          type.value,
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: Fonts.medium600,
                            fontFamily: '',
                            color: type.color,
                          ),
                        ),
                      ],
                    ),
                    RotatedBox(
                      quarterTurns: 2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            type.value,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: Fonts.medium600,
                              fontFamily: '',
                              color: type.color,
                            ),
                          ),
                          Text(
                            type.value,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: Fonts.medium600,
                              fontFamily: '',
                              color: type.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Align(
                  alignment: const AlignmentDirectional(0, -.5),
                  child: Text(
                    type.value,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: Fonts.medium600,
                      fontFamily: '',
                      color: type.color,
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(0, .5),
                  child: RotatedBox(
                    quarterTurns: 2,
                    child: Text(
                      type.value,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: Fonts.medium600,
                        fontFamily: '',
                        color: type.color,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          CardName.nine => Stack(
              alignment: Alignment.center,
              children: [
                Stack(
                  fit: StackFit.expand,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            type.value,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: Fonts.medium600,
                              fontFamily: '',
                              color: type.color,
                            ),
                          ),
                          Text(
                            type.value,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: Fonts.medium600,
                              fontFamily: '',
                              color: type.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: const Alignment(0, -.35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            type.value,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: Fonts.medium600,
                              fontFamily: '',
                              color: type.color,
                            ),
                          ),
                          Text(
                            type.value,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: Fonts.medium600,
                              fontFamily: '',
                              color: type.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: const Alignment(0, .35),
                      child: RotatedBox(
                        quarterTurns: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              type.value,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: Fonts.medium600,
                                fontFamily: '',
                                color: type.color,
                              ),
                            ),
                            Text(
                              type.value,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: Fonts.medium600,
                                fontFamily: '',
                                color: type.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: const Alignment(0, 1),
                      child: RotatedBox(
                        quarterTurns: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              type.value,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: Fonts.medium600,
                                fontFamily: '',
                                color: type.color,
                              ),
                            ),
                            Text(
                              type.value,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: Fonts.medium600,
                                fontFamily: '',
                                color: type.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  type.value,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: Fonts.medium600,
                    fontFamily: '',
                    color: type.color,
                  ),
                ),
              ],
            ),
          CardName.ten => Stack(
              alignment: Alignment.center,
              children: [
                Stack(
                  fit: StackFit.expand,
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            type.value,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: Fonts.medium600,
                              fontFamily: '',
                              color: type.color,
                            ),
                          ),
                          Text(
                            type.value,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: Fonts.medium600,
                              fontFamily: '',
                              color: type.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: const Alignment(0, -.35),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            type.value,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: Fonts.medium600,
                              fontFamily: '',
                              color: type.color,
                            ),
                          ),
                          Text(
                            type.value,
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: Fonts.medium600,
                              fontFamily: '',
                              color: type.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Align(
                      alignment: const Alignment(0, .35),
                      child: RotatedBox(
                        quarterTurns: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              type.value,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: Fonts.medium600,
                                fontFamily: '',
                                color: type.color,
                              ),
                            ),
                            Text(
                              type.value,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: Fonts.medium600,
                                fontFamily: '',
                                color: type.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: const Alignment(0, 1),
                      child: RotatedBox(
                        quarterTurns: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              type.value,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: Fonts.medium600,
                                fontFamily: '',
                                color: type.color,
                              ),
                            ),
                            Text(
                              type.value,
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: Fonts.medium600,
                                fontFamily: '',
                                color: type.color,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      type.value,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: Fonts.medium600,
                        fontFamily: '',
                        color: type.color,
                      ),
                    ),
                    const SizedBox(height: 32),
                    RotatedBox(
                      quarterTurns: 2,
                      child: Text(
                        type.value,
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: Fonts.medium600,
                          fontFamily: '',
                          color: type.color,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          CardName.jack => Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Transform.scale(
                    scale: 1.2,
                    child: SvgPicture.asset(
                      'assets/images/svg/j/${type.svg}',
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(1.2, -.85),
                  child: Text(
                    type.value,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: Fonts.medium600,
                      fontFamily: '',
                      color: type.color,
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(-1.2, .85),
                  child: RotatedBox(
                    quarterTurns: 2,
                    child: Text(
                      type.value,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: Fonts.medium600,
                        fontFamily: '',
                        color: type.color,
                      ),
                    ),
                  ),
                )
              ],
            ),
          CardName.queen => Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Transform.scale(
                    scale: 1.2,
                    child: SvgPicture.asset(
                      'assets/images/svg/q/${type.svg}',
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(1.2, -.85),
                  child: Text(
                    type.value,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: Fonts.medium600,
                      fontFamily: '',
                      color: type.color,
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(-1.2, .85),
                  child: RotatedBox(
                    quarterTurns: 2,
                    child: Text(
                      type.value,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: Fonts.medium600,
                        fontFamily: '',
                        color: type.color,
                      ),
                    ),
                  ),
                )
              ],
            ),
          CardName.king => Stack(
              children: [
                SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Transform.scale(
                    scale: 1.2,
                    child: SvgPicture.asset(
                      'assets/images/svg/k/${type.svg}',
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(1.2, -.85),
                  child: Text(
                    type.value,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: Fonts.medium600,
                      fontFamily: '',
                      color: type.color,
                    ),
                  ),
                ),
                Align(
                  alignment: const AlignmentDirectional(-1.2, .85),
                  child: RotatedBox(
                    quarterTurns: 2,
                    child: Text(
                      type.value,
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: Fonts.medium600,
                        fontFamily: '',
                        color: type.color,
                      ),
                    ),
                  ),
                )
              ],
            )
        },
      ),
    );
  }
}
