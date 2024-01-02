import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:card_game/feature/commands/domain/use_case/listen_for_server_connection.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../user/domain/entity/user.dart';
import '../../domain/entity/network_device.dart';
import '../../domain/entity/server_message.dart';
import '../../domain/use_case/connect_to_server.dart';
import '../../domain/use_case/disconnect_from_server.dart' as dc;
import '../../domain/use_case/send_message.dart' as send;

part 'connect_to_server_event.dart';
part 'connect_to_server_state.dart';

@injectable
class ConnectToServerBloc
    extends Bloc<ConnectToServerEvent, ConnectToServerState> {
  final ConnectToServer _connectToServer;
  final send.SendMessage _sendMessage;
  final dc.DisconnectFromServer _disconnectFromServer;
  final ListenForserverConnection _listenForserverConnection;
  ConnectToServerBloc(
    this._connectToServer,
    this._sendMessage,
    this._disconnectFromServer,
    this._listenForserverConnection,
  ) : super(ConnectToServerInitial()) {
    on<DoConnectToServerEvent>(
      _onDoConnectToServerEvent,
      transformer: droppable(),
    );
    on<SendMessageToServerEvent>(
      _onSendMessageToServerEvent,
      transformer: droppable(),
    );
    on<AddMessageFromServerEvent>(_onAddMessageFromServerEvent);
    on<DisconnectFromServerEvent>(_onDisconnectFromServerEvent);
  }
  StreamSubscription? _messageSub;
  StreamSubscription? _connectionSub;
  User? _user;

  Future<void> _onDoConnectToServerEvent(
    DoConnectToServerEvent event,
    Emitter<ConnectToServerState> emit,
  ) async {
    _user = event.user;
    emit(ConnectToServerLoading());
    final result =
        await _connectToServer(Params(user: event.user, server: event.server));
    final newState = await result.fold(
      (failure) async => failure.toState,
      (response) async {
        _messageSub = response.listen((event) {
          if (!isClosed) add(AddMessageFromServerEvent(item: event));
        });
        _connectionSub = _listenForserverConnection().listen((event) {
          if (isClosed) return;
          if (event) _user = null;
          if (event) add(DisconnectFromServerEvent());
        });
        return const ConnectToServerSuccess();
      },
    );
    emit(newState);
  }

  Future<void> _onSendMessageToServerEvent(
    SendMessageToServerEvent event,
    Emitter<ConnectToServerState> emit,
  ) async {
    final result = await _sendMessage(
        send.Params(message: event.message, user: event.user));
    final newState = await result.fold(
      (failure) async => failure.toState,
      (response) async => const ConnectToServerSuccess(),
    );
    emit(newState);
  }

  Future<void> _onAddMessageFromServerEvent(
    AddMessageFromServerEvent event,
    Emitter<ConnectToServerState> emit,
  ) async {
    emit(ConnectToServerSuccess(item: event.item));
  }

  Future<void> _onDisconnectFromServerEvent(
    DisconnectFromServerEvent event,
    Emitter<ConnectToServerState> emit,
  ) async {
    emit(DisconnectFromServerState());
  }

  @override
  Future<void> close() {
    _closeConnection();
    if (_user != null) _disconnectFromServer(dc.Params(user: _user!));
    return super.close();
  }

  void _closeConnection() {
    _messageSub?.cancel();
    _messageSub = null;
    _connectionSub?.cancel();
    _connectionSub = null;
  }
}

extension FailureToStateExt on Failure {
  ConnectToServerState get toState => switch (this) {
        _ => ConnectToServerFailure(),
      };
}
