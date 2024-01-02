import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/button/m_button.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/extensions.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../commands/domain/entity/network_device.dart';
import '../../../../commands/presentation/bloc/connect_to_server_bloc.dart';
import '../../../../commands/presentation/bloc/players_bloc.dart';
import '../../../../database/presentation/cubit/username_cubit.dart';
import '../../../../language/manager/localizatios.dart';

class UserListWidget extends StatelessWidget {
  final bool isServer;
  const UserListWidget({
    super.key,
    required this.isServer,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayersBloc, PlayersState>(
      builder: (context, state) => BlocBuilder<UsernameCubit, UsernameState>(
        builder: (context, uState) => Container(
          width: 200,
          height: double.infinity,
          color: MColors.bole,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  itemBuilder: (context, index) => _ItemWidget(
                    item: state.items[index],
                    isMe: state.items[index].ip == uState.user.ip,
                  ),
                  itemCount: state.items.length,
                  shrinkWrap: true,
                ),
              ),
              AnimatedCrossFade(
                duration: UiUtils.duration,
                sizeCurve: UiUtils.curve,
                firstCurve: UiUtils.curve,
                secondCurve: UiUtils.curve,
                crossFadeState: isServer || !state.items.is3PlayerReady
                    ? CrossFadeState.showFirst
                    : CrossFadeState.showSecond,
                firstChild: MButtonWidget(
                  borderRadius: BorderRadius.zero,
                  color: MColors.keppel,
                  enableClickWhenDisable: false,
                  onClick: () {
                    if (isServer) {
                      // TODO: implement start game.
                      return;
                    }
                    context.read<ConnectToServerBloc>().add(SetReadyEvent());
                  },
                  isEnable: isServer ? state.items.is3PlayerReady : true,
                  title: isServer
                      ? Strings.of(context).start_label
                      : Strings.of(context).ready_label,
                ),
                secondChild: const SizedBox(width: double.infinity),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final NetworkDevice item;
  final bool isMe;
  const _ItemWidget({
    required this.item,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 38,
      margin: const EdgeInsetsDirectional.only(end: 6, start: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (item.isServer)
            Padding(
              padding: const EdgeInsetsDirectional.only(end: 8, bottom: 4),
              child: Tooltip(
                message: Strings.of(context).im_server_label,
                child: const SizedBox.square(
                  dimension: 24,
                  child: Center(
                    child: Icon(
                      Icons.person,
                      color: MColors.whiteColor,
                    ),
                  ),
                ),
              ),
            ),
          Expanded(
            child: Text(
              item.name,
              style: TextStyle(
                fontSize: 16,
                color: isMe ? MColors.seeGreen : MColors.whiteColor,
                fontWeight: Fonts.medium600,
              ),
            ),
          ),
          AnimatedCrossFade(
            duration: UiUtils.duration,
            sizeCurve: UiUtils.curve,
            firstCurve: UiUtils.curve,
            secondCurve: UiUtils.curve,
            crossFadeState: item.isReady
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            firstChild: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(left: 4, right: 4, bottom: 4),
                  width: 1.5,
                  height: 16,
                  color: MColors.whiteColor.withOpacity(.25),
                ),
                Text(
                  Strings.of(context).ready_label,
                  style: const TextStyle(
                    fontSize: 12,
                    color: MColors.keppel,
                    fontWeight: Fonts.regular500,
                  ),
                ),
              ],
            ),
            secondChild: const SizedBox(height: 38),
          ),
        ],
      ),
    );
  }
}
