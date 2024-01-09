import 'package:card_game/core/utils/assets.dart';
import 'package:flutter/material.dart';

import '../../feature/language/manager/localizatios.dart';

enum CardType {
  spades,
  hearts,
  diamonds,
  clubs;

  String get value => switch (this) {
        CardType.spades => '♠',
        CardType.hearts => '♥',
        CardType.diamonds => '♦',
        CardType.clubs => '♣',
      };

  Color get color => switch (this) {
        CardType.spades => MColors.jet,
        CardType.hearts => MColors.scarlet,
        CardType.diamonds => MColors.scarlet,
        CardType.clubs => MColors.jet,
      };

  String get svg => switch (this) {
        CardType.spades => 's.svg',
        CardType.hearts => 'h.svg',
        CardType.diamonds => 'd.svg',
        CardType.clubs => 'c.svg',
      };
}

enum CardName {
  ace,
  two,
  three,
  four,
  five,
  six,
  seven,
  eight,
  nine,
  ten,
  jack,
  queen,
  king;

  String get value => switch (this) {
        CardName.ace => 'A',
        CardName.two => '2',
        CardName.three => '3',
        CardName.four => '4',
        CardName.five => '5',
        CardName.six => '6',
        CardName.seven => '7',
        CardName.eight => '8',
        CardName.nine => '9',
        CardName.ten => '10',
        CardName.jack => 'J',
        CardName.queen => 'Q',
        CardName.king => 'K',
      };
}

enum MenuItem {
  createServer,
  connectToServer,
  settings,
  exit,
}

enum ButtonType {
  fill,
  outline,
  text,
  textAndIcon,
}

enum ServerMessageType {
  message,
  join,
  leave,
  startGame;

  String get value => switch (this) {
        ServerMessageType.message => 'msg',
        ServerMessageType.join => 'jn',
        ServerMessageType.leave => 'lve',
        ServerMessageType.startGame => 'strt-gme',
      };

  String toStringValue(BuildContext context, String user) => switch (this) {
        ServerMessageType.message => '',
        ServerMessageType.join => Strings.of(context)
            .user_connected_place_holder
            .replaceFirst('\$0', user),
        ServerMessageType.leave => Strings.of(context)
            .user_disconnected_place_holder
            .replaceFirst('\$0', user),
        ServerMessageType.startGame => '',
      };
}

enum GameCommands {
  shuffle,
  playHand,
}

enum GameStep {
  loading,
  shuffeling,
  shuffelingDone,
  dealingP1,
  dealingP2,
  dealingP3,
  dealingP4,
  p1,
  p2,
  p3,
  p4,
}
