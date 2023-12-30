import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/components/button/m_button.dart';
import '../../../core/components/input/m_input_widget.dart';
import '../../../core/utils/assets.dart';
import '../../../core/utils/utils.dart';
import '../../language/manager/localizatios.dart';
import 'base_dialog_widget.dart';

class _Cubit extends Cubit<_State> {
  _Cubit() : super(_State.init());

  void updateReason(String declineReasonText) =>
      emit(state.copyWith(username: declineReasonText));

  _State? declineFinancingRequest() {
    if (!state.isEnable) {
      emit(state.copyWith(showError: true));
      return null;
    }
    final newState = state.copyWith(showError: false);
    emit(newState);
    return newState;
  }
}

class _State extends Equatable {
  final bool showError;
  final String username;

  const _State({
    required this.showError,
    required this.username,
  });

  @override
  List<Object> get props => [
        showError,
        username,
      ];

  factory _State.init() => const _State(
        showError: false,
        username: '',
      );

  _State copyWith({
    bool? showError,
    String? username,
  }) =>
      _State(
        showError: showError ?? this.showError,
        username: username ?? this.username,
      );

  bool get isEnable {
    if (invalidUsername) return false;
    return true;
  }

  bool get invalidUsername => username.isEmpty;
}

class UsernameDialogWidget extends StatelessWidget {
  const UsernameDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseDialogWidget(
      child: Container(
        width: UiUtils.dialogWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: MColors.secondaryColor,
        ),
        child: _bodyWidget,
      ),
    );
  }

  Widget get _bodyWidget => Builder(
        builder: (context) => Padding(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: 48,
            vertical: 32,
          ),
          child: BlocProvider<_Cubit>(
            create: (context) => _Cubit(),
            child: _BodyWidget(
              onSubmitClick: Navigator.of(context).pop,
            ),
          ),
        ),
      );
}

class _BodyWidget extends StatefulWidget {
  final Function(String value) onSubmitClick;
  const _BodyWidget({
    Key? key,
    required this.onSubmitClick,
  }) : super(key: key);

  @override
  State<_BodyWidget> createState() => _BodyWidgetState();
}

class _BodyWidgetState extends State<_BodyWidget> {
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
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _titleWidget,
        const SizedBox(height: 10),
        _subTitleWidget,
        const SizedBox(height: 35),
        _inputWidget,
        const SizedBox(height: 35),
        _sendReasonButton,
      ],
    );
  }

  Widget get _titleWidget => Builder(
        builder: (context) => Text(
          Strings.of(context).user_name,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: Fonts.regular500,
            color: MColors.whiteColor,
          ),
        ),
      );

  Widget get _subTitleWidget => Builder(
        builder: (context) => Text(
          Strings.of(context).user_name_description,
          style: TextStyle(
            fontSize: 14,
            fontWeight: Fonts.thin400,
            color: MColors.whiteColor.withOpacity(.8),
          ),
        ),
      );

  Widget get _inputWidget => BlocBuilder<_Cubit, _State>(
        buildWhen: (previous, current) =>
            (previous.showError != current.showError) ||
            (previous.username != current.username),
        builder: (context, state) {
          return MInputWidget(
            controller: _controller,
            onTextChange: context.read<_Cubit>().updateReason,
            focusNode: _focusNode,
            hint: Strings.of(context).user_name,
            height: UiUtils.inputHeight,
            error: () {
              if (!state.showError || !state.invalidUsername) {
                return null;
              }
              return Strings.of(context).user_name_error;
            }(),
          );
        },
      );

  Widget get _sendReasonButton => BlocBuilder<_Cubit, _State>(
        builder: (context, state) => MButtonWidget(
          isEnable: state.isEnable,
          onClick: _onSubmitClick,
          title: Strings.of(context).save_label,
          width: double.infinity,
        ),
      );

  void _onSubmitClick() {
    final state = context.read<_Cubit>().declineFinancingRequest();
    if (state == null) return;
    widget.onSubmitClick(state.username);
  }
}
