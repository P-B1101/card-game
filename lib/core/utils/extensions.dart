import 'package:flutter/material.dart';

import '../../feature/cards/domain/entity/card.dart';
import '../../feature/language/manager/localizatios.dart';
import '../../feature/user/domain/entity/user.dart';
import 'enum.dart';

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
        MenuItem.quickGame => Strings.of(context).menu_item_quick_game,
        MenuItem.settings => Strings.of(context).menu_item_settings,
        MenuItem.exit => Strings.of(context).menu_item_exit,
      };
}
