part of 'create_server_bloc.dart';

sealed class CreateServerEvent extends Equatable {
  const CreateServerEvent();

  @override
  List<Object> get props => [];
}

final class DoCreateServerEvent extends CreateServerEvent {}