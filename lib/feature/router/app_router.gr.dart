// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:card_game/feature/board/presentation/page/board_page.dart'
    as _i1;
import 'package:card_game/feature/commands/domain/entity/network_device.dart'
    as _i7;
import 'package:card_game/feature/menu/presentation/page/lobby_page.dart'
    as _i2;
import 'package:card_game/feature/menu/presentation/page/menu_page.dart' as _i3;
import 'package:card_game/feature/menu/presentation/page/server_list_page.dart'
    as _i4;
import 'package:flutter/material.dart' as _i6;

abstract class $AppRouter extends _i5.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i5.PageFactory> pagesMap = {
    BoardRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.BoardPage(),
      );
    },
    LobbyRoute.name: (routeData) {
      final args = routeData.argsAs<LobbyRouteArgs>(
          orElse: () => const LobbyRouteArgs());
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.LobbyPage(
          key: args.key,
          device: args.device,
        ),
      );
    },
    MenuRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.MenuPage(),
      );
    },
    ServerListRoute.name: (routeData) {
      return _i5.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.ServerListPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.BoardPage]
class BoardRoute extends _i5.PageRouteInfo<void> {
  const BoardRoute({List<_i5.PageRouteInfo>? children})
      : super(
          BoardRoute.name,
          initialChildren: children,
        );

  static const String name = 'BoardRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i2.LobbyPage]
class LobbyRoute extends _i5.PageRouteInfo<LobbyRouteArgs> {
  LobbyRoute({
    _i6.Key? key,
    _i7.NetworkDevice? device,
    List<_i5.PageRouteInfo>? children,
  }) : super(
          LobbyRoute.name,
          args: LobbyRouteArgs(
            key: key,
            device: device,
          ),
          initialChildren: children,
        );

  static const String name = 'LobbyRoute';

  static const _i5.PageInfo<LobbyRouteArgs> page =
      _i5.PageInfo<LobbyRouteArgs>(name);
}

class LobbyRouteArgs {
  const LobbyRouteArgs({
    this.key,
    this.device,
  });

  final _i6.Key? key;

  final _i7.NetworkDevice? device;

  @override
  String toString() {
    return 'LobbyRouteArgs{key: $key, device: $device}';
  }
}

/// generated route for
/// [_i3.MenuPage]
class MenuRoute extends _i5.PageRouteInfo<void> {
  const MenuRoute({List<_i5.PageRouteInfo>? children})
      : super(
          MenuRoute.name,
          initialChildren: children,
        );

  static const String name = 'MenuRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}

/// generated route for
/// [_i4.ServerListPage]
class ServerListRoute extends _i5.PageRouteInfo<void> {
  const ServerListRoute({List<_i5.PageRouteInfo>? children})
      : super(
          ServerListRoute.name,
          initialChildren: children,
        );

  static const String name = 'ServerListRoute';

  static const _i5.PageInfo<void> page = _i5.PageInfo<void>(name);
}
