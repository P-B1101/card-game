import 'package:flutter/material.dart';

import '../../../core/components/button/m_button.dart';
import '../../../core/utils/assets.dart';
import '../../../core/utils/utils.dart';
import '../../language/manager/localizatios.dart';
import 'base_dialog_widget.dart';

class ServerDisconnectedDialogWidget extends StatelessWidget {
  const ServerDisconnectedDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseDialogWidget(
      child: Container(
        width: UiUtils.dialogWidth * .7,
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _titleWidget,
              const SizedBox(height: 10),
              _subTitleWidget,
              const SizedBox(height: 35),
              _actionButtonWidget,
            ],
          ),
        ),
      );

  Widget get _titleWidget => Builder(
        builder: (context) => Text(
          Strings.of(context).server_disconnected_title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: Fonts.regular500,
            color: MColors.whiteColor,
          ),
        ),
      );

  Widget get _subTitleWidget => Builder(
        builder: (context) => Text(
          Strings.of(context).server_disconnected_description,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            fontWeight: Fonts.thin400,
            color: MColors.whiteColor.withOpacity(.8),
          ),
        ),
      );

  Widget get _actionButtonWidget => Builder(
        builder: (context) => MButtonWidget(
          onClick: Navigator.of(context).pop,
          title: Strings.of(context).ok_label,
          width: double.infinity,
        ),
      );
}
