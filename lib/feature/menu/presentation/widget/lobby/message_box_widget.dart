import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/input/m_input_widget.dart';
import '../../../../../core/utils/assets.dart';
import '../../../../../core/utils/enum.dart';
import '../../../../../core/utils/utils.dart';
import '../../../../commands/domain/entity/server_message.dart';
import '../../../../commands/presentation/bloc/connect_to_server_bloc.dart';
import '../../../../commands/presentation/bloc/create_server_bloc.dart';
import '../../../../database/presentation/cubit/username_cubit.dart';
import '../../../../language/manager/localizatios.dart';

class MessageBoxWidget extends StatefulWidget {
  const MessageBoxWidget({super.key});

  @override
  State<MessageBoxWidget> createState() => _MessageBoxWidgetState();
}

class _MessageBoxWidgetState extends State<MessageBoxWidget> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateServerBloc, CreateServerState>(
      builder: (context, state) => Container(
        // height: 200,
        width: double.infinity,
        decoration: const BoxDecoration(
          color: MColors.secondaryColor,
        ),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: state.messages.length,
                reverse: true,
                shrinkWrap: true,
                itemBuilder: (context, index) => FadedSlideAnimation(
                  beginOffset: const Offset(0, .05),
                  endOffset: const Offset(0, 0),
                  fadeCurve: UiUtils.curve,
                  slideCurve: UiUtils.curve,
                  fadeDuration: UiUtils.duration,
                  slideDuration: UiUtils.duration,
                  child: BlocBuilder<UsernameCubit, UsernameState>(
                    builder: (context, uState) {
                      return _MessageItemWidget(
                        message: state.messages[index],
                        isMe:
                            state.messages[index].user == uState.user.username,
                      );
                    },
                  ),
                ),
              ),
            ),
            Container(
              height: 64,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16),
              color: MColors.secondaryColor,
              alignment: Alignment.center,
              child: MInputWidget(
                controller: _controller,
                focusNode: _focusNode,
                hint: Strings.of(context).send_message_hint,
                onSubmit: (value) => _sendMessage(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _sendMessage() {
    if (_controller.text.isEmpty) return;
    final state = context.read<UsernameCubit>().state;
    if (!state.hasUser) return;
    context.read<ConnectToServerBloc>().add(
          SendMessageToServerEvent(
            message: _controller.text,
            user: state.user,
          ),
        );
    _controller.clear();
    _focusNode.requestFocus();
  }
}

class _MessageItemWidget extends StatelessWidget {
  final ServerMessage message;
  final bool isMe;
  const _MessageItemWidget({
    required this.message,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(
        start: 16,
        end: 12,
        top: 4,
        bottom: 4,
      ),
      child: message.status != ServerMessageStatus.message
          ? Text(
              message.status.toStringValue(context, message.user),
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 14,
                fontWeight: Fonts.regular500,
                color: MColors.whiteColor.withOpacity(.5),
              ),
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${message.user}: ',
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: Fonts.black800,
                    color: isMe ? MColors.seeGreen : MColors.ecru,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Text(
                      message.message,
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: Fonts.light300,
                        color: MColors.whiteColor.withOpacity(.9),
                      ),
                    ),
                  ),
                )
              ],
            ),
    );
  }
}
