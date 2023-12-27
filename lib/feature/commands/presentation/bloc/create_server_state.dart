part of 'create_server_bloc.dart';

sealed class CreateServerState extends Equatable {
  const CreateServerState();
  
  @override
  List<Object> get props => [];
}

final class CreateServerInitial extends CreateServerState {}

final class CreateServerLoading extends CreateServerState {}

final class CreateServerSuccess extends CreateServerState {}

final class CreateServerFailure extends CreateServerState {}
