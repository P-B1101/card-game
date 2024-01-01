import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/assets.dart';
import '../../../../commands/presentation/bloc/players_bloc.dart';
import '../../../../database/presentation/cubit/username_cubit.dart';

class UserListWidget extends StatelessWidget {
  const UserListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PlayersBloc, PlayersState>(
      builder: (context, state) => BlocBuilder<UsernameCubit, UsernameState>(
        builder: (context, uState) => Container(
          width: 200,
          height: double.infinity,
          color: MColors.ecru,
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 6),
            itemBuilder: (context, index) => _ItemWidget(
              name: index == 0
                  ? uState.user.username
                  : state.items[index - 1].name,
              isMe: index == 0,
            ),
            itemCount: state.items.length + 1,
            shrinkWrap: true,
            // reverse: true,
          ),
        ),
      ),
    );
  }
}

class _ItemWidget extends StatelessWidget {
  final String name;
  final bool isMe;
  const _ItemWidget({
    required this.name,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: Text(
        name,
        style: TextStyle(
          fontSize: 16,
          color: isMe ? MColors.secondaryColor : MColors.whiteColor,
          fontWeight: Fonts.medium600,
        ),
      ),
    );
  }
}
