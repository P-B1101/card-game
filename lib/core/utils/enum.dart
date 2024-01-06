import 'package:flutter/material.dart';

import '../../feature/language/manager/localizatios.dart';

enum CardType {
  spades,
  hearts,
  diamonds,
  clubs,
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
  king,
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
