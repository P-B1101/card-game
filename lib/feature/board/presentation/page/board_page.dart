import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/container/toolbar_widget.dart';
import '../../../../core/utils/assets.dart';
import '../../../../injectable_container.dart';
import '../../../commands/domain/entity/network_device.dart';
import '../../../commands/presentation/bloc/connect_to_server_bloc.dart';
import '../../../commands/presentation/bloc/create_server_bloc.dart';
import '../../../database/presentation/cubit/username_cubit.dart';
import '../../../dialog/manager/dialog_manager.dart';
import '../../../router/app_router.gr.dart';

@RoutePage()
class BoardPage extends StatelessWidget {
  static const path = 'board';
  final NetworkDevice? device;
  const BoardPage({
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
      ],
      child: _BoardPage(device: device),
    );
  }
}

class _BoardPage extends StatefulWidget {
  final NetworkDevice? device;
  const _BoardPage({
    required this.device,
  });

  @override
  State<_BoardPage> createState() => __BoardPageState();
}

class __BoardPageState extends State<_BoardPage> {
  late final _createServerBloc = context.read<CreateServerBloc>();
  late final _userCubit = context.read<UsernameCubit>();
  @override
  void initState() {
    super.initState();
    _handleInitState();
  }

  @override
  void dispose() {
    _createServerBloc.add(DisconnectServerEvent.board(_userCubit.state.user));
    super.dispose();
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
      child: Scaffold(
        backgroundColor: MColors.secondaryColor,
        body: Center(
          child: Text(
            'Game board',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: MColors.whiteColor,
                ),
          ),
        ),
      ),
    );
  }

  void _handleInitState() {
    context
        .read<ToolbarCubit>()
        .setCallback(() => context.navigateTo(const MenuRoute()));
    final state = context.read<UsernameCubit>().state;
    if (_isServer) {
      _createServerBloc.add(DoCreateServerEvent.board(state.user));
    } else {
      _joinToServer();
    }
  }

  void _joinToServer() {
    final state = context.read<UsernameCubit>().state;
    context.read<ConnectToServerBloc>().add(DoConnectToServerEvent.board(
          user: state.user,
          server: widget.device,
        ));
  }

  void _handleCreateServerState(CreateServerState state) {
    if (state is CreateServerSuccess) _joinToServer();
    if (state is CreateServerFailure) {
      // TODO: show error.
      debugPrint('fail to create server');
      return;
    }
  }

  void showServerDisconnectedDialog() async {
    await DialogManager.instance.showServerDisconnectedDialog(context);
    if (!mounted) return;
    context.navigateTo(const MenuRoute());
  }

  void _handleConnectToServerState(ConnectToServerState state) {
    if (state is ConnectToServerSuccess && state.item != null) {
      // if (state.item?.isStartGame ?? false) {
      //   _handleStartGame();
      // }
      //_createServerBloc.add(AddMessageEvent(message: state.item!));
      // context.read<PlayersBloc>().add(GetPlayersEvent());
    }
    if (state is DisconnectFromServerState) {
      if (!state.isLobby) showServerDisconnectedDialog();
    }
  }

  bool get _isServer => widget.device == null;
}
