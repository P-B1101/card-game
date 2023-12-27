// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i3;
import 'package:card_game/feature/board/presentation/page/board_page.dart'
    as _i1;
import 'package:card_game/feature/menu/presentation/page/menu_page.dart' as _i2;

abstract class $AppRouter extends _i3.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i3.PageFactory> pagesMap = {
    BoardRoute.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.BoardPage(),
      );
    },
    MenuRoute.name: (routeData) {
      return _i3.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.MenuPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.BoardPage]
class BoardRoute extends _i3.PageRouteInfo<void> {
  const BoardRoute({List<_i3.PageRouteInfo>? children})
      : super(
          BoardRoute.name,
          initialChildren: children,
        );

  static const String name = 'BoardRoute';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}

/// generated route for
/// [_i2.MenuPage]
class MenuRoute extends _i3.PageRouteInfo<void> {
  const MenuRoute({List<_i3.PageRouteInfo>? children})
      : super(
          MenuRoute.name,
          initialChildren: children,
        );

  static const String name = 'MenuRoute';

  static const _i3.PageInfo<void> page = _i3.PageInfo<void>(name);
}
