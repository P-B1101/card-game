// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i4;
import 'package:card_game/feature/board/presentation/page/board_page.dart'
    as _i1;
import 'package:card_game/feature/menu/presentation/page/lobby_page.dart'
    as _i2;
import 'package:card_game/feature/menu/presentation/page/menu_page.dart' as _i3;

abstract class $AppRouter extends _i4.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i4.PageFactory> pagesMap = {
    BoardRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.BoardPage(),
      );
    },
    LobbyRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.LobbyPage(),
      );
    },
    MenuRoute.name: (routeData) {
      return _i4.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.MenuPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.BoardPage]
class BoardRoute extends _i4.PageRouteInfo<void> {
  const BoardRoute({List<_i4.PageRouteInfo>? children})
      : super(
          BoardRoute.name,
          initialChildren: children,
        );

  static const String name = 'BoardRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i2.LobbyPage]
class LobbyRoute extends _i4.PageRouteInfo<void> {
  const LobbyRoute({List<_i4.PageRouteInfo>? children})
      : super(
          LobbyRoute.name,
          initialChildren: children,
        );

  static const String name = 'LobbyRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}

/// generated route for
/// [_i3.MenuPage]
class MenuRoute extends _i4.PageRouteInfo<void> {
  const MenuRoute({List<_i4.PageRouteInfo>? children})
      : super(
          MenuRoute.name,
          initialChildren: children,
        );

  static const String name = 'MenuRoute';

  static const _i4.PageInfo<void> page = _i4.PageInfo<void>(name);
}
