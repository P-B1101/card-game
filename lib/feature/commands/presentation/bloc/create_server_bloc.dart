import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../user/domain/entity/user.dart';
import '../../domain/entity/server_message.dart';
import '../../domain/use_case/close_server.dart' as cls;
import '../../domain/use_case/create_server.dart';

part 'create_server_event.dart';
part 'create_server_state.dart';

@injectable
class CreateServerBloc extends Bloc<CreateServerEvent, CreateServerState> {
  final CreateServer _createServer;
  final cls.CloseServer _closeServer;
  CreateServerBloc(
    this._createServer,
    this._closeServer,
  ) : super(CreateServerInitial()) {
    on<DoCreateServerEvent>(_onDoCreateServerEvent, transformer: droppable());
    on<AddMessageEvent>(_onAddMessageEvent);
    on<DisconnectServerEvent>(
      _onDisconnectServerEvent,
      transformer: droppable(),
    );
  }

  Future<void> _onDoCreateServerEvent(
    DoCreateServerEvent event,
    Emitter<CreateServerState> emit,
  ) async {
    emit(CreateServerLoading());
    final result = await _createServer(Params(
      user: event.user,
      isLobby: event.isLobby,
    ));
    await result.fold(
      (failure) async => emit(failure.toState),
      (response) async => emit(CreateServerSuccess()),
    );
  }

  Future<void> _onAddMessageEvent(
    AddMessageEvent event,
    Emitter<CreateServerState> emit,
  ) async {
    emit(ServerMessageReceived(messages: [event.message, ...state.messages]));
  }

  Future<void> _onDisconnectServerEvent(
    DisconnectServerEvent event,
    Emitter<CreateServerState> emit,
  ) async {
    _closeServer(cls.Params(user: event.user, isLobby: event.isLobby));
  }
}

extension FailureToStateExt on Failure {
  CreateServerState get toState => switch (this) {
        _ => CreateServerFailure(),
      };
}
