import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/components/input/m_input_widget.dart';
import '../../../../../core/utils/assets.dart';
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
        height: 200,
        width: double.infinity,
        decoration: BoxDecoration(
          color: MColors.secondaryColor,
          border: Border.all(width: 1, color: MColors.primaryColor),
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
                  child: _MessageItemWidget(
                    message: state.messages[index],
                  ),
                ),
              ),
            ),
            Container(
              height: 56,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 8),
                  _sendButtonWidget,
                  const SizedBox(width: 8),
                  Expanded(
                    child: MInputWidget(
                      controller: _controller,
                      focusNode: _focusNode,
                      hint: Strings.of(context).send_message_hint,
                      onSubmit: (value) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget get _sendButtonWidget => Builder(
        builder: (context) => Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: MColors.primaryColor,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: _sendMessage,
              borderRadius: BorderRadius.circular(8),
              child: const RotatedBox(
                quarterTurns: 2,
                child: Icon(
                  Icons.send_rounded,
                  color: MColors.whiteColor,
                ),
              ),
            ),
          ),
        ),
      );

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
  const _MessageItemWidget({
    required this.message,
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
      child: message.isFirstConnection
          ? Text(
              message.isFirstConnection
                  ? Strings.of(context)
                      .user_connected_place_holder
                      .replaceFirst('\$0', message.user)
                  : '${message.user}: ${message.message}',
              textAlign: TextAlign.start,
              style: TextStyle(
                fontSize: 14,
                fontWeight: Fonts.regular500,
                color: MColors.whiteColor
                    .withOpacity(message.isFirstConnection ? .5 : 1),
              ),
            )
          : Row(
              children: [
                Text(
                  '${message.user}: ',
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: Fonts.regular500,
                    color: MColors.whiteColor,
                  ),
                ),
                Text(
                  message.message,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: Fonts.regular500,
                    color: MColors.whiteColor.withOpacity(.9),
                  ),
                )
              ],
            ),
    );
  }
}
