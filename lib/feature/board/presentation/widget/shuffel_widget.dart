import 'package:card_game/core/components/button/m_button.dart';
import 'package:card_game/feature/language/manager/localizatios.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/utils.dart';
import '../../../cards/presentation/widget/card_widget.dart';
import '../cubit/game_controller_cubit.dart';

class ShuffelWidget extends StatelessWidget {
  const ShuffelWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameControllerCubit, GameControllerState>(
      builder: (context, state) => state.isStarted
          ? Stack(
              children: List.generate(
                state.cards.length,
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
                      padding: EdgeInsetsDirectional.only(
                        start: index * 2,
                      ),
                      child: CardWidget.back(
                        state.cards[index],
                      ),
                    ),
                    secondChild: const SizedBox(width: 120),
                  ),
                ),
              ),
            )
          : MButtonWidget(
              width: 200,
              onClick: context.read<GameControllerCubit>().shuffelingDone,
              title: Strings.of(context).start_label,
            ),
    );
  }
}
