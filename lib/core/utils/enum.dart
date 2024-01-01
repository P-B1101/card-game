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

enum ServerMessageStatus {
  message,
  join,
  leave;

  String get value => switch (this) {
        ServerMessageStatus.message => 'msg',
        ServerMessageStatus.join => 'jn',
        ServerMessageStatus.leave => 'lve',
      };

  String toStringValue(BuildContext context, String user) => switch (this) {
        ServerMessageStatus.message => '',
        ServerMessageStatus.join => Strings.of(context)
            .user_connected_place_holder
            .replaceFirst('\$0', user),
        ServerMessageStatus.leave => Strings.of(context)
            .user_disconnected_place_holder
            .replaceFirst('\$0', user),
      };
}
