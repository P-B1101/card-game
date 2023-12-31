import 'package:auto_route/auto_route.dart';
import 'package:card_game/feature/router/app_router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/assets.dart';
import '../../../../injectable_container.dart';
import '../../../commands/domain/entity/network_device.dart';
import '../../../commands/presentation/bloc/network_device_bloc.dart';
import '../widget/server_list/server_list_widget.dart';

@RoutePage()
class ServerListPage extends StatelessWidget {
  static const path = 'servers';
  const ServerListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NetworkDeviceBloc>(
          create: (context) => getIt<NetworkDeviceBloc>(),
        ),
      ],
      child: const _ServerListPage(),
    );
  }
}

class _ServerListPage extends StatefulWidget {
  const _ServerListPage();

  @override
  State<_ServerListPage> createState() => __ServerListPageState();
}

class __ServerListPageState extends State<_ServerListPage> {
  @override
  void initState() {
    super.initState();
    _handleInitState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MColors.secondaryColor,
      body: ServerListWidget(onClick: _onServerClick),
    );
  }

  void _handleInitState() {
    context.read<NetworkDeviceBloc>().add(GetNetworkDeviceEvent());
  }

  void _onServerClick(NetworkDevice device) {
    context.navigateTo(LobbyRoute(device: device));
  }
}
