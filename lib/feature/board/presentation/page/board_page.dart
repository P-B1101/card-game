import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/components/container/toolbar_widget.dart';
import '../../../../core/components/loading/board_loading_widget.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/utils.dart';
import '../../../../injectable_container.dart';
import '../../../commands/domain/entity/network_device.dart';
import '../../../commands/presentation/bloc/connect_to_server_bloc.dart';
import '../../../commands/presentation/bloc/create_server_bloc.dart';
import '../../../commands/presentation/bloc/players_bloc.dart';
import '../../../database/presentation/cubit/username_cubit.dart';
import '../../../dialog/manager/dialog_manager.dart';
import '../../../language/manager/localizatios.dart';
import '../../../router/app_router.gr.dart';
import '../../../user/domain/entity/user.dart';
import '../cubit/game_controller_cubit.dart';
import '../widget/player_table_widget.dart';
import '../widget/shuffeled_cards_widget.dart';

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
        BlocProvider<PlayersBloc>(
          create: (context) => getIt<PlayersBloc>(),
        ),
        BlocProvider<GameControllerCubit>(
          create: (context) => getIt<GameControllerCubit>(),
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
  late CreateServerBloc _createServerBloc = context.read<CreateServerBloc>();
  late User _user = context.read<UsernameCubit>().state.user;
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
    _createServerBloc.add(DisconnectServerEvent.board(_user));
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
        BlocListener<PlayersBloc, PlayersState>(
          listener: (context, state) => _handlePlayersState(state),
        ),
        BlocListener<GameControllerCubit, GameControllerState>(
          listener: (context, state) => _handleGameControllerState(state),
        ),
      ],
      child: Scaffold(
        backgroundColor: MColors.secondaryColor,
        body: BlocBuilder<GameControllerCubit, GameControllerState>(
          builder: (context, state) => AnimatedSwitcher(
            duration: UiUtils.duration,
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            child: state.isLoading
                ? Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          Strings.of(context).board_loading,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: Fonts.bold700,
                            color: MColors.whiteColor,
                          ),
                        ),
                        const SizedBox(width: 8),
                        const BoardLoadingWidget(),
                      ],
                    ),
                  )
                : Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: BlocBuilder<PlayersBloc, PlayersState>(
                          builder: (context, pState) =>
                              BlocBuilder<UsernameCubit, UsernameState>(
                            builder: (context, state) {
                              final players = pState.items.where(
                                  (element) => element.ip != state.user.ip);
                              return RotatedBox(
                                quarterTurns: 2,
                                child: PlayerTableWidget(
                                  player: players.firstOrNull,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: BlocBuilder<PlayersBloc, PlayersState>(
                          builder: (context, pState) =>
                              BlocBuilder<UsernameCubit, UsernameState>(
                            builder: (context, state) {
                              final players = pState.items.where(
                                  (element) => element.ip != state.user.ip);
                              return RotatedBox(
                                quarterTurns: 1,
                                child: PlayerTableWidget(
                                  player: players.elementAtOrNull(1),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional.centerStart,
                        child: BlocBuilder<PlayersBloc, PlayersState>(
                          builder: (context, pState) =>
                              BlocBuilder<UsernameCubit, UsernameState>(
                            builder: (context, state) {
                              final players = pState.items.where(
                                  (element) => element.ip != state.user.ip);
                              return RotatedBox(
                                quarterTurns: 3,
                                child: PlayerTableWidget(
                                  player: players.elementAtOrNull(2),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: BlocBuilder<PlayersBloc, PlayersState>(
                          builder: (context, pState) =>
                              BlocBuilder<UsernameCubit, UsernameState>(
                            builder: (context, state) {
                              final me = pState.items
                                  .where(
                                      (element) => element.ip == state.user.ip)
                                  .firstOrNull;
                              return PlayerTableWidget(player: me);
                            },
                          ),
                        ),
                      ),
                      const Center(child: ShuffeledCardsWidget()),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  void _handleInitState() async {
    context
        .read<ToolbarCubit>()
        .setCallback(() => context.navigateTo(const MenuRoute()));
    final state = context.read<UsernameCubit>().state;
    await Future.delayed(const Duration(milliseconds: 2000));
    if (!mounted) return;
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

  void _handleConnectToServerState(ConnectToServerState state) async {
    if (state is ConnectToServerSuccess && state.item != null) {
      context.read<PlayersBloc>().add(GetPlayersEvent());
      if (mounted) context.read<GameControllerCubit>().loadingDone();
      return;
    }
    if (state is DisconnectFromServerState) {
      if (!state.isLobby) showServerDisconnectedDialog();
    }
  }

  void _handlePlayersState(PlayersState state) async {
    if (state is AddPlayerState) {
      context.read<GameControllerCubit>().initPlayers(state.items);
      return;
    }
  }

  void _handleGameControllerState(GameControllerState state) {
    if (state.isShuffeling) {
      context.read<GameControllerCubit>().dealingP1();
    }
  }

  bool get _isServer => widget.device == null;
}
