import 'package:card_game/core/utils/assets.dart';
import 'package:flutter/material.dart';

import '../../../commands/domain/entity/network_device.dart';

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
        ],
      ),
    );
  }
}
