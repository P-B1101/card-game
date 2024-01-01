import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/utils/assets.dart';
import '../../../database/presentation/cubit/username_cubit.dart';

class UsernameWidget extends StatelessWidget {
  final Widget child;
  const UsernameWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: child),
        Align(
          alignment: AlignmentDirectional.bottomStart,
          child: BlocBuilder<UsernameCubit, UsernameState>(
            builder: (context, state) => state.hasUser
                ? Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        state.user.username,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: Fonts.thin400,
                          color: MColors.whiteColor.withOpacity(.25),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
        ),
        Align(
          alignment: AlignmentDirectional.bottomEnd,
          child: BlocBuilder<UsernameCubit, UsernameState>(
            builder: (context, state) => state.hasUser
                ? Material(
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 2),
                      child: Text(
                        state.user.ip,
                        style: TextStyle(
                          fontSize: 12,
                          fontFamily: '',
                          color: MColors.whiteColor.withOpacity(.25),
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ),
        ),
      ],
    );
  }
}
