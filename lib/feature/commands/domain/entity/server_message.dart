import 'package:equatable/equatable.dart';

import '../../../../core/utils/enum.dart';

class ServerMessage extends Equatable {
  final String user;
  final String message;
  final ServerMessageStatus status;

  const ServerMessage({
    required this.message,
    required this.user,
    required this.status,
  });

  @override
  List<Object?> get props => [user, message, status];

  factory ServerMessage.hello(String username) => ServerMessage(
        message: '',
        user: username,
        status: ServerMessageStatus.join,
      );

  factory ServerMessage.goodby(String username) => ServerMessage(
        message: '',
        user: username,
        status: ServerMessageStatus.leave,
      );

  factory ServerMessage.message(String username, String message) =>
      ServerMessage(
        message: message,
        user: username,
        status: ServerMessageStatus.message,
      );
}
