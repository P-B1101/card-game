import 'package:flutter/material.dart';

import '../../../../core/utils/utils.dart';
import '../../../cards/domain/entity/card.dart';
import '../../../cards/presentation/widget/card_widget.dart';

class PlayerCardsWidget extends StatelessWidget {
  final List<MCard> items;
  const PlayerCardsWidget({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: List.generate(
        items.length,
        (index) => FutureBuilder<bool>(
          initialData: false,
          future: Future.delayed(Duration(milliseconds: 150 * index))
              .then((value) => true),
          builder: (context, snapshot) => AnimatedCrossFade(
            duration: UiUtils.duration * .5,
            sizeCurve: UiUtils.curve,
            firstCurve: UiUtils.curve,
            secondCurve: UiUtils.curve,
            crossFadeState: snapshot.data == true
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            firstChild: Padding(
              padding: EdgeInsetsDirectional.only(start: index * 5),
              child: CardWidget.back(items[index]),
            ),
            secondChild: const SizedBox(),
          ),
        ),
      ),
    );
  }
}
