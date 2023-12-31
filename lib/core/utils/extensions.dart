import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../../feature/cards/domain/entity/card.dart';
import '../../feature/commands/domain/entity/network_device.dart';
import '../../feature/language/manager/localizatios.dart';
import '../../feature/user/domain/entity/user.dart';
import 'enum.dart';

extension DateTimeExt on DateTime {
  String get generateId => '$year${month.toTwoDigit}${day.toTwoDigit}'
      '${hour.toTwoDigit}${minute.toTwoDigit}${second.toTwoDigit}'
      '${millisecond.toThreeDigit}${microsecond.toThreeDigit}';
}

extension IntExt on int {
  String get toTwoDigit => this >= 0 && this < 10 ? '0$this' : '$this';

  String get toThreeDigit => this >= 0 && this < 10
      ? '00$this'
      : this < 100
          ? '0$this'
          : '$this';
}

extension StringExt on String {
  ServerMessageType? get toServerMessageStatus => switch (this) {
        'msg' => ServerMessageType.message,
        'jn' => ServerMessageType.join,
        'lve' => ServerMessageType.leave,
        'strt-gme' => ServerMessageType.startGame,
        _ => null,
      };
}

extension DoubleExt on double {
  bool get isSmall => this <= 360;

  bool get isExtraSmall => this <= 311;

  double get scaleFactor => isExtraSmall
      ? .9
      : isSmall
          ? 1.0
          : 1.1;
}

extension MCardListExt on List<MCard> {
  User? calcWinner(CardType mainType) {
    final cards = this;
    final user = cards.hasMainType(mainType);
    if (user != null) return user;
    return cards.getHigherScore;
  }

  User? hasMainType(CardType mainType) {
    final cards = this;
    final temp = <MCard>[];
    for (int i = 0; i < cards.length; i++) {
      if (cards[i].type == mainType) temp.add(cards[i]);
    }
    if (temp.isEmpty) return null;
    return cards.getHigherScore;
  }

  User? get getHigherScore {
    final cards = this;
    int index = 0;
    for (int i = 0; i < cards.length; i++) {
      if (cards[i].score > cards[index].score) index = i;
    }
    return cards[index].owner;
  }
}

extension MenuItemExt on MenuItem {
  String toStringValue(BuildContext context) => switch (this) {
        MenuItem.createServer => Strings.of(context).menu_item_create_server,
        MenuItem.connectToServer =>
          Strings.of(context).menu_item_connect_to_server,
        MenuItem.settings => Strings.of(context).menu_item_settings,
        MenuItem.exit => Strings.of(context).menu_item_exit,
      };
}

extension NetworkDeviceListExt on List<NetworkDevice> {
  bool get is3PlayerReady {
    int counter = 0;
    for (int i = 0; i < length; i++) {
      if (!this[i].isServer && this[i].isReady) counter++;
      if (counter >= 3) return true;
    }
    return false;
  }

  void addIfNotExist(NetworkDevice item) {
    for (int i = 0; i < length; i++) {
      if (this[i].id == item.id) return;
    }
    add(item);
  }

  void toggleReadyWhere(String ip) {
    for (int i = 0; i < length; i++) {
      if (this[i].ip != ip) continue;
      this[i] = this[i].toggleReady();
      break;
    }
  }

  void removeIfExist(String id) {
    for (int i = 0; i < length; i++) {
      if (this[i].id == id) {
        removeAt(i);
        return;
      }
    }
  }
}

extension MapStringDynamicExt on Map<String, dynamic> {
  T? toEnum<T extends Enum>(String key, T? Function(String value) converter) {
    final value = this[key];
    if (value is! String) return null;
    return converter(value);
  }

  T? toModel<T extends Equatable>(
    String key,
    T? Function(dynamic value) converter,
  ) {
    final value = this[key];
    if (value == null) return null;
    return converter(value);
  }

  List<T> toListModel<T extends Equatable>(
    String key,
    T Function(dynamic value) converter,
  ) {
    final value = this[key];
    if (value is! List) return <T>[];
    return value.map((e) => converter(e)).toList();
  }
}

extension ListTExt<T> on List<T> {
  List<T> get getLastFour {
    if (length < 4) {
      final items = sublist(0);
      clear();
      return items;
    }
    final items = sublist(length - 4);
    removeRange(length - 4, length);
    return items;
  }
}

extension UserCardsRecordExt on ({User user, List<MCard> cards}) {
  ({User user, List<MCard> cards}) copyWith({
    User? user,
    List<MCard>? cards,
  }) =>
      (user: user ?? this.user, cards: cards ?? this.cards);
}
