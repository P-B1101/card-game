import '../../../core/utils/enum.dart';
import '../domain/entity/card.dart';

class CardManager {
  const CardManager._();

  static List<MCard> get getNewRandomCards {
    const cardNames = CardName.values;
    const types = CardType.values;
    final items = <MCard>[];
    for (int i = 0; i < types.length; i++) {
      for (int j = 0; j < cardNames.length; j++) {
        items.add(MCard.init(type: types[i], name: cardNames[j]));
      }
    }
    items.shuffle();
    return items;
  }
}
