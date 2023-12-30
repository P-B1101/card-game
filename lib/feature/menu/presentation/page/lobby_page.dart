import 'package:auto_route/auto_route.dart';
import 'package:card_game/feature/router/app_router.gr.dart';
import 'package:card_game/injectable_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/assets.dart';
import '../../../commands/presentation/bloc/connect_to_server_bloc.dart';
import '../../../commands/presentation/bloc/create_server_bloc.dart';
import '../../../database/presentation/cubit/username_cubit.dart';
import '../../../dialog/manager/dialog_manager.dart';
import '../widget/lobby/message_box_widget.dart';

@RoutePage()
class LobbyPage extends StatelessWidget {
  static const path = 'lobby';
  const LobbyPage({super.key});

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
      child: const _LobbyPage(),
    );
  }
}

class _LobbyPage extends StatefulWidget {
  const _LobbyPage();

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
      ],
      child: const Scaffold(
        backgroundColor: MColors.grayColor,
        body: Center(
          child: Column(
            children: [
              Expanded(child: SizedBox()),
              MessageBoxWidget(),
            ],
          ),
        ),
      ),
    );
  }

  void _handleInitState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CreateServerBloc>().add(DoCreateServerEvent());
    });
  }

  void _joinToServer() {
    final state = context.read<UsernameCubit>().state;
    if (state.hasUser) {
      context
          .read<ConnectToServerBloc>()
          .add(DoConnectToServerEvent(user: state.user));
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
    final user = context.read<UsernameCubit>().saveUser(username);
    context.read<ConnectToServerBloc>().add(DoConnectToServerEvent(user: user));
  }

  void _handleCreateServerState(CreateServerState state) {
    if (state is CreateServerSuccess) _joinToServer();
    if (state is CreateServerFailure) {
      // TODO: show error.
      debugPrint('fail to create server');
      return;
    }
  }
}
