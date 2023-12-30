part of 'create_server_bloc.dart';

sealed class CreateServerState extends Equatable {
  final List<ServerMessage> messages;
  const CreateServerState({
    this.messages = const [],
  });

  @override
  List<Object> get props => [messages];
}

final class CreateServerInitial extends CreateServerState {}

final class CreateServerLoading extends CreateServerState {}

final class CreateServerSuccess extends CreateServerState {}

final class ServerMessageReceived extends CreateServerState {
  const ServerMessageReceived({
    required super.messages,
  });
}

final class CreateServerFailure extends CreateServerState {}
