import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/assets.dart';
import '../../../commands/domain/entity/network_device.dart';
import '../cubit/game_controller_cubit.dart';
import 'player_cards_widget.dart';

class PlayerTableWidget extends StatelessWidget {
  final NetworkDevice? player;

  const PlayerTableWidget({
    super.key,
    required this.player,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 150,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(8),
        ),
        color: MColors.bole,
      ),
      child: Stack(
        children: [
          Align(
            alignment: AlignmentDirectional.bottomStart,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              child: Text(
                player?.name ?? '-',
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: Fonts.medium600,
                  color: MColors.whiteColor,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: BlocBuilder<GameControllerCubit, GameControllerState>(
              builder: (context, state) => Transform.scale(
                scale: .8,
                child: PlayerCardsWidget(
                  items: state.getCards(player),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
