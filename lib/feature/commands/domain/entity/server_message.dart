import 'package:card_game/core/utils/extensions.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/utils/enum.dart';

class ServerMessage extends Equatable {
  final String id;
  final String user;
  final String message;
  final ServerMessageType status;

  const ServerMessage({
    required this.id,
    required this.message,
    required this.user,
    required this.status,
  });

  @override
  List<Object?> get props => [user, message, status];

  factory ServerMessage.hello(String username) => ServerMessage(
        id: '',
        message: '',
        user: username,
        status: ServerMessageType.join,
      );

  factory ServerMessage.goodby(String username) => ServerMessage(
        id: '',
        message: '',
        user: username,
        status: ServerMessageType.leave,
      );

  factory ServerMessage.countDown(int countDown) => ServerMessage(
        id: '',
        message: '$countDown',
        user: '',
        status: ServerMessageType.startGame,
      );

  factory ServerMessage.message(String username, String message) =>
      ServerMessage(
        id: DateTime.now().generateId,
        message: message,
        user: username,
        status: ServerMessageType.message,
      );

  bool get isStartGame => status == ServerMessageType.startGame;
}
