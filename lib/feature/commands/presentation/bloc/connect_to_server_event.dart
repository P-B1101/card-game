part of 'connect_to_server_bloc.dart';

sealed class ConnectToServerEvent extends Equatable {
  const ConnectToServerEvent();

  @override
  List<Object> get props => [];
}

final class DoConnectToServerEvent extends ConnectToServerEvent {
  final User user;
  const DoConnectToServerEvent({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}
