import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../commands/presentation/bloc/connect_to_server_bloc.dart';
import '../../../commands/presentation/bloc/create_server_bloc.dart';
import '../../../user/domain/entity/user.dart';

@RoutePage()
class LobbyPage extends StatelessWidget {
  static const path = 'lobby';
  const LobbyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _LobbyPage();
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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CreateServerBloc>().add(DoCreateServerEvent());
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CreateServerBloc, CreateServerState>(
          listener: (context, state) {
            if (state is CreateServerSuccess) {
              context.read<ConnectToServerBloc>().add(
                  const DoConnectToServerEvent(user: User(username: 'b1101')));
            }
          },
        ),
        BlocListener<ConnectToServerBloc, ConnectToServerState>(
          listener: (context, state) {},
        ),
      ],
      child: Scaffold(
        body: Center(
          child: Column(
            children: [
              BlocBuilder<CreateServerBloc, CreateServerState>(
                builder: (context, state) => Text(state.toString()),
              ),
              const SizedBox(height: 24),
              BlocBuilder<ConnectToServerBloc, ConnectToServerState>(
                builder: (context, state) => Text(state.toString()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
