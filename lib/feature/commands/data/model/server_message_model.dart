import 'package:card_game/core/utils/enum.dart';
import 'package:card_game/core/utils/extensions.dart';

import '../../domain/entity/server_message.dart';

class ServerMessageModel extends ServerMessage {
  const ServerMessageModel({
    required super.message,
    required super.user,
    required super.status,
    required super.id,
  });

  factory ServerMessageModel.fromEntity(ServerMessage entity) =>
      ServerMessageModel(
        id: entity.id,
        message: entity.message,
        user: entity.user,
        status: entity.status,
      );

  @override
  factory ServerMessageModel.hello(String username) => ServerMessageModel(
        id: '',
        message: '',
        user: username,
        status: ServerMessageType.join,
      );
  @override
  factory ServerMessageModel.goodby(String username) => ServerMessageModel(
        id: '',
        message: '',
        user: username,
        status: ServerMessageType.leave,
      );

  @override
  factory ServerMessageModel.message(String username, String message) =>
      ServerMessageModel(
        id: DateTime.now().generateId,
        message: message,
        user: username,
        status: ServerMessageType.message,
      );

  @override
  factory ServerMessageModel.countDown(int countDown) => ServerMessageModel(
        id: '',
        message: '$countDown',
        user: '',
        status: ServerMessageType.startGame,
      );

  factory ServerMessageModel.fromJson(Map<String, dynamic> json) =>
      ServerMessageModel(
        id: json['id'],
        message: json['message'],
        user: json['user'],
        status: json.toEnum('status', (value) => value.toServerMessageStatus) ??
            ServerMessageType.message,
      );

  Map<String, dynamic> get toJson => {
        'id': id,
        'user': user,
        'message': message,
        'status': status.value,
      };
}
