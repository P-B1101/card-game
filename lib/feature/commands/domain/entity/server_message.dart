import 'package:equatable/equatable.dart';

class ServerMessage extends Equatable {
  final String user;
  final String message;
  final bool isFirstConnection;

  const ServerMessage({
    required this.message,
    required this.user,
    required this.isFirstConnection,
  });

  @override
  List<Object?> get props => [user, message, isFirstConnection];

  factory ServerMessage.hello(String username) => ServerMessage(
        message: '',
        user: username,
        isFirstConnection: true,
      );

  factory ServerMessage.message(String username, String message) =>
      ServerMessage(
        message: message,
        user: username,
        isFirstConnection: false,
      );
}
