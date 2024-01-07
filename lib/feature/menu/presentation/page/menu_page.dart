import 'package:auto_route/auto_route.dart';
import 'package:card_game/core/components/container/toolbar_widget.dart';
import 'package:card_game/feature/database/presentation/cubit/username_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/assets.dart';
import '../../../../core/utils/enum.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/utils.dart';
import '../../../cards/presentation/widget/card_widget.dart';
import '../../../language/manager/localizatios.dart';
import '../../../router/app_router.gr.dart';
import '../widget/menu/menu_item_widget.dart';

@RoutePage()
class MenuPage extends StatelessWidget {
  static const path = 'menu';
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _MenuPage();
  }
}

class _MenuPage extends StatefulWidget {
  const _MenuPage();

  @override
  State<_MenuPage> createState() => __MenuPageState();
}

class __MenuPageState extends State<_MenuPage> {
  @override
  void initState() {
    super.initState();
    _handleInitState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.secondaryColor,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              Strings.of(context).menu_title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: Fonts.bold700,
                color: MColors.whiteColor,
              ),
            ),
            CardWidget.front(type: CardType.spades, name: CardName.ten),
            const SizedBox(height: 32),
            Flexible(
              child: ListView.builder(
                itemCount: MenuItem.values.length,
                shrinkWrap: true,
                itemBuilder: (context, index) => Center(
                  child: MenuItemWidget(
                    title: MenuItem.values[index].toStringValue(context),
                    onClick: () => _onClick(MenuItem.values[index]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleInitState() {
    context.read<ToolbarCubit>().showBack(false);
    context.read<UsernameCubit>().getUser();
  }

  void _onClick(MenuItem item) {
    switch (item) {
      case MenuItem.createServer:
        context.read<ToolbarCubit>().showBack(true);
        context.pushRoute(LobbyRoute());
        break;
      case MenuItem.connectToServer:
        context.read<ToolbarCubit>().showBack(true);
        context.pushRoute(const ServerListRoute());
        break;
      case MenuItem.settings:
        break;
      case MenuItem.exit:
        Utils.exitApp();
        break;
    }
  }
}
