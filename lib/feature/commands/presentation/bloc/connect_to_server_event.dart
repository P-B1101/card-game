part of 'connect_to_server_bloc.dart';

sealed class ConnectToServerEvent extends Equatable {
  const ConnectToServerEvent();

  @override
  List<Object?> get props => [];
}

final class DoConnectToServerEvent extends ConnectToServerEvent {
  final User user;
  final NetworkDevice? server;
  const DoConnectToServerEvent({
    required this.user,
    required this.server,
  });

  @override
  List<Object?> get props => [user, server];
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

final class DisconnectFromServerEvent extends ConnectToServerEvent {}
