import 'package:flutter/material.dart';

import '../presentation/server_disconnected_dialog_widget.dart';
import '../presentation/username_dialog_widget.dart';

class DialogManager {
  const DialogManager._();

  static const DialogManager _instance = DialogManager._();

  static DialogManager get instance => _instance;

  static bool _showSaveUsernameDialog = false;
  static bool _showServerDisconnectedDialog = false;

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

  Future<void> showServerDisconnectedDialog(BuildContext context) async {
    if (_showServerDisconnectedDialog) return;
    _showServerDisconnectedDialog = true;
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Dialog(
        insetPadding: EdgeInsets.zero,
        backgroundColor: Colors.transparent,
        child: ServerDisconnectedDialogWidget(),
      ),
      barrierColor: Colors.transparent,
    );
    _showServerDisconnectedDialog = false;
  }
}
