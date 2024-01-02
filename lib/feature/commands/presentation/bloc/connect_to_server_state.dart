part of 'connect_to_server_bloc.dart';

sealed class ConnectToServerState extends Equatable {
  const ConnectToServerState();

  @override
  List<Object?> get props => [];
}

final class ConnectToServerInitial extends ConnectToServerState {}

final class ConnectToServerLoading extends ConnectToServerState {}

final class ConnectToServerSuccess extends ConnectToServerState {
  final ServerMessage? item;
  const ConnectToServerSuccess({
    this.item,
  });

  @override
  List<Object?> get props => [item];
}

final class ConnectToServerFailure extends ConnectToServerState {}


final class DisconnectFromServerState extends ConnectToServerState {}
