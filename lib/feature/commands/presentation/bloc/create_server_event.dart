part of 'create_server_bloc.dart';

sealed class CreateServerEvent extends Equatable {
  const CreateServerEvent();

  @override
  List<Object> get props => [];
}

final class DoCreateServerEvent extends CreateServerEvent {
  final User user;
  final bool isLobby;
  const DoCreateServerEvent({
    required this.user,
    required this.isLobby,
  });

  @override
  List<Object> get props => [user, isLobby];

  factory DoCreateServerEvent.lobby(User user) =>
      DoCreateServerEvent(isLobby: true, user: user);

  factory DoCreateServerEvent.board(User user) =>
      DoCreateServerEvent(isLobby: false, user: user);
}

final class AddMessageEvent extends CreateServerEvent {
  final ServerMessage message;
  const AddMessageEvent({
    required this.message,
  });

  @override
  List<Object> get props => [message];

  factory AddMessageEvent.countDown(int countDown) =>
      AddMessageEvent(message: ServerMessage.countDown(countDown));
}

final class DisconnectServerEvent extends CreateServerEvent {
  final User user;
  final bool isLobby;
  const DisconnectServerEvent({
    required this.user,
    required this.isLobby,
  });
  @override
  List<Object> get props => [user, isLobby];

  factory DisconnectServerEvent.lobby(User user) =>
      DisconnectServerEvent(user: user, isLobby: true);

  factory DisconnectServerEvent.board(User user) =>
      DisconnectServerEvent(user: user, isLobby: false);
}
