part of 'connect_to_server_bloc.dart';

sealed class ConnectToServerEvent extends Equatable {
  const ConnectToServerEvent();

  @override
  List<Object?> get props => [];
}

final class DoConnectToServerEvent extends ConnectToServerEvent {
  final User user;
  final NetworkDevice? server;
  final bool isLobby;
  const DoConnectToServerEvent({
    required this.user,
    required this.server,
    required this.isLobby,
  });

  @override
  List<Object?> get props => [user, server, isLobby];

  factory DoConnectToServerEvent.lobby({
    required User user,
    required NetworkDevice? server,
  }) =>
      DoConnectToServerEvent(isLobby: true, server: server, user: user);

  factory DoConnectToServerEvent.board({
    required User user,
    required NetworkDevice? server,
  }) =>
      DoConnectToServerEvent(isLobby: false, server: server, user: user);
}

final class SendMessageToServerEvent extends ConnectToServerEvent {
  final String message;
  final User user;
  const SendMessageToServerEvent({
    required this.message,
    required this.user,
  });

  @override
  List<Object> get props => [user, message];
}

final class AddMessageFromServerEvent extends ConnectToServerEvent {
  final ServerMessage item;
  const AddMessageFromServerEvent({
    required this.item,
  });
  @override
  List<Object> get props => [item];
}

final class DisconnectFromServerEvent extends ConnectToServerEvent {
  final bool isLobby;

  const DisconnectFromServerEvent({
    required this.isLobby,
  });

  @override
  List<Object?> get props => [isLobby];
}

final class SetReadyEvent extends ConnectToServerEvent {}

final class StartGameEvent extends ConnectToServerEvent {}
