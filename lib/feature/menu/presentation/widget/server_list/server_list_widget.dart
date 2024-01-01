import 'package:auto_route/auto_route.dart';
import 'package:card_game/core/components/loading/adaptive_loading_widget.dart';
import 'package:card_game/core/utils/utils.dart';
import 'package:card_game/feature/router/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/assets.dart';
import '../../../../commands/domain/entity/network_device.dart';
import '../../../../commands/presentation/bloc/network_device_bloc.dart';
import '../../../../language/manager/localizatios.dart';

class ServerListWidget extends StatelessWidget {
  final Function(NetworkDevice) onClick;

  const ServerListWidget({
    super.key,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NetworkDeviceBloc, NetworkDeviceState>(
      builder: (context, state) => AnimatedSwitcher(
        duration: UiUtils.duration,
        switchInCurve: Curves.easeIn,
        switchOutCurve: Curves.easeOut,
        child: () {
          final isLoading =
              state is NetworkDeviceLoadingState && state.items.isEmpty;
          if (isLoading) return const Center(child: AdaptiveLoadingWidget());
          if (state is NetworkDeviceFailureState) {
            return Center(
              child: Text(Strings.of(context).general_error),
            );
          }
          return ListView.builder(
            itemCount: state.items.length + 1,
            shrinkWrap: true,
            itemBuilder: (context, index) => _ItemWidget(
              index: index,
              item: index == 0 ? null : state.items[index - 1],
              onClick: onClick,
            ),
          );
        }(),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final NetworkDevice? item;
  final int index;
  final Function(NetworkDevice) onClick;
  const _ItemWidget({
    required this.index,
    required this.item,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      width: double.infinity,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: item == null ? null : () => onClick(item!),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                _Title(_isHeader ? '#' : index.toString()),
                Container(
                  width: 1.5,
                  height: 12,
                  color: _isHeader ? MColors.grayColor : Colors.transparent,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                ),
                Expanded(
                  child: _Title(
                    _isHeader
                        ? Strings.of(context).name_label
                        : item?.name ?? '-',
                  ),
                ),
                Container(
                  width: 1.5,
                  height: 12,
                  color: _isHeader ? MColors.grayColor : Colors.transparent,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                ),
                SizedBox(
                  width: 150,
                  child: _Title(
                    _isHeader ? Strings.of(context).ip_label : item?.ip ?? '-',
                    TextAlign.start
                  ),
                ),
                _isHeader ? _backButtonWidget : const SizedBox(width: 42),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget get _backButtonWidget => Builder(
        builder: (context) => RotatedBox(
          quarterTurns: 2,
          child: BackButton(
            color: MColors.whiteColor,
            onPressed: () => context.navigateTo(const MenuRoute()),
          ),
        ),
      );

  bool get _isHeader => item == null;
}

class _Title extends StatelessWidget {
  final String text;
  final TextAlign? textAlign;
  const _Title(this.text, [this.textAlign]);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: const TextStyle(
        fontSize: 14,
        color: MColors.whiteColor,
        fontWeight: Fonts.regular500,
      ),
    );
  }
}
