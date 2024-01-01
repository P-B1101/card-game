import 'package:card_game/core/utils/enum.dart';
import 'package:card_game/core/utils/extensions.dart';

import '../../domain/entity/server_message.dart';

class ServerMessageModel extends ServerMessage {
  const ServerMessageModel({
    required super.message,
    required super.user,
    required super.status,
  });

  factory ServerMessageModel.fromEntity(ServerMessage entity) =>
      ServerMessageModel(
        message: entity.message,
        user: entity.user,
        status: entity.status,
      );

  @override
  factory ServerMessageModel.hello(String username) => ServerMessageModel(
        message: '',
        user: username,
        status: ServerMessageStatus.join,
      );
  @override
  factory ServerMessageModel.goodby(String username) => ServerMessageModel(
        message: '',
        user: username,
        status: ServerMessageStatus.leave,
      );

  @override
  factory ServerMessageModel.message(String username, String message) =>
      ServerMessageModel(
        message: message,
        user: username,
        status: ServerMessageStatus.message,
      );

  factory ServerMessageModel.fromJson(Map<String, dynamic> json) =>
      ServerMessageModel(
        message: json['message'],
        user: json['user'],
        status: json.toEnum('status', (value) => value.toServerMessageStatus) ??
            ServerMessageStatus.message,
      );

  Map<String, dynamic> get toJson => {
        'user': user,
        'message': message,
        'status': status.value,
      };
}
