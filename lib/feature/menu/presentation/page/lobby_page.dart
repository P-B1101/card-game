import 'package:auto_route/auto_route.dart';
import 'package:card_game/core/components/container/toolbar_widget.dart';
import 'package:card_game/feature/commands/presentation/bloc/players_bloc.dart';
import 'package:card_game/feature/user/domain/entity/user.dart';
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
import '../cubit/start_game_cubit.dart';
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
        BlocProvider<StartGameCubit>(
          create: (context) => getIt<StartGameCubit>(),
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
  late CreateServerBloc _createServerBloc = context.read<CreateServerBloc>();
  late User _user;

  @override
  void initState() {
    super.initState();
    _handleInitState();
  }

  @override
  void didChangeDependencies() {
    _user = context.read<UsernameCubit>().state.user;
    _createServerBloc = context.read<CreateServerBloc>();
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _createServerBloc.add(DisconnectServerEvent.lobby(_user));
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
        BlocListener<StartGameCubit, StartGameState>(
          listenWhen: (previuos, current) =>
              previuos.countDown != current.countDown,
          listener: (context, state) =>
              _createServerBloc.add(AddMessageEvent.countDown(state.countDown)),
        ),
      ],
      child: Scaffold(
        backgroundColor: MColors.secondaryColor,
        body: Row(
          children: [
            UserListWidget(isServer: _isServer),
            const Expanded(child: MessageBoxWidget()),
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
          _createServerBloc.add(DoCreateServerEvent.lobby(state.user));
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
      context.read<ConnectToServerBloc>().add(DoConnectToServerEvent.lobby(
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
      _createServerBloc.add(DoCreateServerEvent.lobby(user));
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

  void showServerDisconnectedDialog() async {
    await DialogManager.instance.showServerDisconnectedDialog(context);
    if (!mounted) return;
    context.navigateTo(const MenuRoute());
  }

  void _handleStartGame() async {
    final isPlayer = await context.read<StartGameCubit>().startCountDown();
    if (!mounted) return;
    if (!isPlayer) return;
    context.navigateTo(BoardRoute(device: widget.device));
  }

  void _handleConnectToServerState(ConnectToServerState state) {
    if (state is ConnectToServerSuccess && state.item != null) {
      if (state.item?.isStartGame ?? false) {
        _handleStartGame();
      }
      _createServerBloc.add(AddMessageEvent(message: state.item!));
      context.read<PlayersBloc>().add(GetPlayersEvent());
    }
    if (state is DisconnectFromServerState) {
      if (state.isLobby) showServerDisconnectedDialog();
    }
  }

  bool get _isServer => widget.device == null;
}
