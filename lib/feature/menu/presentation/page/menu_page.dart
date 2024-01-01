import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/assets.dart';
import '../../../../core/utils/enum.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../core/utils/utils.dart';
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
        context.pushRoute(LobbyRoute());
        break;
      case MenuItem.connectToServer:
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
