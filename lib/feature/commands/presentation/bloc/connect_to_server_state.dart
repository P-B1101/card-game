part of 'connect_to_server_bloc.dart';

sealed class ConnectToServerState extends Equatable {
  const ConnectToServerState();
  
  @override
  List<Object> get props => [];
}

final class ConnectToServerInitial extends ConnectToServerState {}

final class ConnectToServerLoading extends ConnectToServerState {}

final class ConnectToServerSuccess extends ConnectToServerState {}

final class ConnectToServerFailure extends ConnectToServerState {}
