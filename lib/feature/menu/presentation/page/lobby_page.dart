import 'package:auto_route/auto_route.dart';
import 'package:card_game/core/components/container/toolbar_widget.dart';
import 'package:card_game/feature/commands/presentation/bloc/players_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/assets.dart';
import '../../../../injectable_container.dart';
import '../../../commands/domain/entity/network_device.dart';
import '../../../commands/presentation/bloc/connect_to_server_bloc.dart';
import '../../../commands/presentation/bloc/create_server_bloc.dart';
import '../../../database/presentation/cubit/username_cubit.dart';
import '../../../dialog/manager/dialog_manager.dart';
import '../../../router/app_router.gr.dart';
import '../widget/lobby/message_box_widget.dart';
import '../widget/lobby/user_list_widget.dart';

@RoutePage()
class LobbyPage extends StatelessWidget {
  static const path = 'lobby';
  final NetworkDevice? device;
  const LobbyPage({
    super.key,
    this.device,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CreateServerBloc>(
          create: (context) => getIt<CreateServerBloc>(),
        ),
        BlocProvider<ConnectToServerBloc>(
          create: (context) => getIt<ConnectToServerBloc>(),
        ),
        BlocProvider<PlayersBloc>(
          create: (context) => getIt<PlayersBloc>(),
        ),
      ],
      child: _LobbyPage(device: device),
    );
  }
}

class _LobbyPage extends StatefulWidget {
  final NetworkDevice? device;
  const _LobbyPage({
    required this.device,
  });

  @override
  State<_LobbyPage> createState() => __LobbyPageState();
}

class __LobbyPageState extends State<_LobbyPage> {
  @override
  void initState() {
    super.initState();
    _handleInitState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CreateServerBloc, CreateServerState>(
          listener: (context, state) => _handleCreateServerState(state),
        ),
        BlocListener<ConnectToServerBloc, ConnectToServerState>(
          listener: (context, state) => _handleConnectToServerState(state),
        ),
      ],
      child: const Scaffold(
        backgroundColor: MColors.ebony,
        body: Row(
          children: [
            UserListWidget(),
            Expanded(
              child: Column(
                children: [
                  Expanded(child: SizedBox()),
                  MessageBoxWidget(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleInitState() {
    context
        .read<ToolbarCubit>()
        .setCallback(() => context.navigateTo(const MenuRoute()));
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final state = context.read<UsernameCubit>().state;
      if (state.hasUser) {
        if (_isServer) {
          context
              .read<CreateServerBloc>()
              .add(DoCreateServerEvent(user: state.user));
        } else {
          _joinToServer();
        }
        return;
      }
      _showGetUsername();
    });
  }

  void _joinToServer() {
    final state = context.read<UsernameCubit>().state;
    if (state.hasUser) {
      context.read<ConnectToServerBloc>().add(DoConnectToServerEvent(
            user: state.user,
            server: widget.device,
          ));
      return;
    }
    _showGetUsername();
  }

  void _showGetUsername() async {
    final username =
        await DialogManager.instance.showSaveUsernameDialog(context);
    if (!mounted) return;
    if (username == null) {
      context.pushRoute(const MenuRoute());
      return;
    }
    final user = await context.read<UsernameCubit>().saveUser(username);
    if (!mounted) return;
    if (_isServer) {
      context.read<CreateServerBloc>().add(DoCreateServerEvent(user: user));
    } else {
      _joinToServer();
    }
  }

  void _handleCreateServerState(CreateServerState state) {
    if (state is CreateServerSuccess) _joinToServer();
    if (state is CreateServerFailure) {
      // TODO: show error.
      debugPrint('fail to create server');
      return;
    }
  }

  void _handleConnectToServerState(ConnectToServerState state) {
    if (state is ConnectToServerSuccess && state.item != null) {
      context
          .read<CreateServerBloc>()
          .add(AddMessageEvent(message: state.item!));
      context.read<PlayersBloc>().add(GetPlayersEvent());
    }
  }

  bool get _isServer => widget.device == null;
}
