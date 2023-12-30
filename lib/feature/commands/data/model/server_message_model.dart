import '../../domain/entity/server_message.dart';

class ServerMessageModel extends ServerMessage {
  const ServerMessageModel({
    required super.message,
    required super.user,
    required super.isFirstConnection,
  });

  factory ServerMessageModel.fromEntity(ServerMessage entity) =>
      ServerMessageModel(
        message: entity.message,
        user: entity.user,
        isFirstConnection: entity.isFirstConnection,
      );

  @override
  factory ServerMessageModel.hello(String username) => ServerMessageModel(
        message: '',
        user: username,
        isFirstConnection: true,
      );

  @override
  factory ServerMessageModel.message(String username, String message) =>
      ServerMessageModel(
        message: message,
        user: username,
        isFirstConnection: false,
      );

  factory ServerMessageModel.fromJson(Map<String, dynamic> json) =>
      ServerMessageModel(
        message: json['message'],
        user: json['user'],
        isFirstConnection: json['isFirstConnection'],
      );

  Map<String, dynamic> get toJson => {
        'user': user,
        'message': message,
        'isFirstConnection': isFirstConnection,
      };
}
