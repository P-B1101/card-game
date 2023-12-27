import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../board/presentation/page/board_page.dart';
import '../menu/presentation/page/lobby_page.dart';
import '../menu/presentation/page/menu_page.dart';
import 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page|Screen|Widget,Route')
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        RedirectRoute(path: '/', redirectTo: '/${MenuPage.path}'),
        AutoRoute(
          path: '/${MenuPage.path}',
          page: MenuRoute.page,
          maintainState: false,
          keepHistory: false,
        ),
        AutoRoute(
          path: '/${LobbyPage.path}',
          page: LobbyRoute.page,
          maintainState: false,
          keepHistory: false,
        ),
        AutoRoute(
          path: '/${BoardPage.path}',
          page: BoardRoute.page,
          maintainState: false,
          keepHistory: false,
        ),
      ];

  @override
  RouteType get defaultRouteType => RouteType.custom(
        durationInMilliseconds: 200,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = 0.0;
          var end = 1.0;
          var tween = Tween<double>(begin: begin, end: end);
          var curvedAnimation = CurvedAnimation(
            parent: animation,
            reverseCurve: Curves.easeIn,
            curve: Curves.easeOut,
          );

          return FadeTransition(
            opacity: tween.animate(curvedAnimation),
            child: child,
          );
        },
      );

  static PageRoute getRoute({
    required Widget page,
    required RouteSettings settings,
  }) =>
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        settings: settings,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = 0.0;
          var end = 1.0;

          var tween = Tween<double>(begin: begin, end: end);
          var curvedAnimation = CurvedAnimation(
            parent: animation,
            reverseCurve: Curves.easeIn,
            curve: Curves.easeOut,
          );
          return FadeTransition(
            opacity: tween.animate(curvedAnimation),
            child: child,
          );
        },
      );
}
