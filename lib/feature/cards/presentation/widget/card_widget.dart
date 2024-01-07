import 'package:flutter/material.dart';

import '../../../../core/utils/assets.dart';
import '../../../../core/utils/enum.dart';

class CardWidget extends StatelessWidget {
  final CardType type;
  final CardName name;
  final bool isVisible;
  const CardWidget({
    super.key,
    required this.name,
    required this.type,
    required this.isVisible,
  });

  factory CardWidget.front({
    required CardType type,
    required CardName name,
  }) =>
      CardWidget(name: name, type: type, isVisible: true);

  factory CardWidget.back({
    required CardType type,
    required CardName name,
  }) =>
      CardWidget(name: name, type: type, isVisible: false);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      child: AspectRatio(
        aspectRatio: .71,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: MColors.whiteColor,
              ),
              child: Stack(
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
            ),
          ],
        ),
      ),
    );
  }
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
          CardName.jack => Column(),
          CardName.queen => Column(),
          CardName.king => Column(),
        },
      ),
    );
  }
}
