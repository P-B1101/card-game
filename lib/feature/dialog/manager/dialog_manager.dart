import 'package:flutter/material.dart';

import '../presentation/username_dialog_widget.dart';

class DialogManager {
  const DialogManager._();

  static const DialogManager _instance = DialogManager._();

  static DialogManager get instance => _instance;

  static bool _showSaveUsernameDialog = false;

  Future<String?> showSaveUsernameDialog(BuildContext context) async {
    if (_showSaveUsernameDialog) return null;
    _showSaveUsernameDialog = true;
    final result = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        child: UsernameDialogWidget(),
      ),
      barrierColor: Colors.transparent,
    );
    _showSaveUsernameDialog = false;
    return result;
  }
}
