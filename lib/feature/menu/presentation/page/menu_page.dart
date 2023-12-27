import 'package:auto_route/auto_route.dart';
import 'package:card_game/core/utils/assets.dart';
import 'package:card_game/core/utils/extensions.dart';
import 'package:card_game/core/utils/utils.dart';
import 'package:card_game/feature/language/manager/localizatios.dart';
import 'package:card_game/feature/menu/presentation/widget/menu_item_widget.dart';
import 'package:card_game/feature/router/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/utils/enum.dart';

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
            const SizedBox(height: 32),
            ListView.builder(
              itemCount: MenuItem.values.length,
              shrinkWrap: true,
              itemBuilder: (context, index) => Center(
                child: MenuItemWidget(
                  title: MenuItem.values[index].toStringValue(context),
                  onClick: () => _onClick(MenuItem.values[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onClick(MenuItem item) {
    switch (item) {
      case MenuItem.createServer:
        context.pushRoute(const LobbyRoute());
        break;
      case MenuItem.connectToServer:
        break;
      case MenuItem.settings:
        break;
      case MenuItem.exit:
        Utils.exitApp();
        break;
    }
  }
}
