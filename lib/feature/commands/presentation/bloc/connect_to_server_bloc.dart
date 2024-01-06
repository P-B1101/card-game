import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:card_game/feature/commands/domain/use_case/start_game.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../../../user/domain/entity/user.dart';
import '../../domain/entity/network_device.dart';
import '../../domain/entity/server_message.dart';
import '../../domain/use_case/connect_to_server.dart';
import '../../domain/use_case/disconnect_from_server.dart' as dc;
import '../../domain/use_case/listen_for_server_connection.dart';
import '../../domain/use_case/send_message.dart' as send;
import '../../domain/use_case/set_ready.dart';

part 'connect_to_server_event.dart';
part 'connect_to_server_state.dart';

@injectable
class ConnectToServerBloc
    extends Bloc<ConnectToServerEvent, ConnectToServerState> {
  final ConnectToServer _connectToServer;
  final send.SendMessage _sendMessage;
  final dc.DisconnectFromServer _disconnectFromServer;
  final ListenForserverConnection _listenForserverConnection;
  final SetReady _setReady;
  final StartGame _startGame;
  ConnectToServerBloc(
    this._connectToServer,
    this._sendMessage,
    this._disconnectFromServer,
    this._listenForserverConnection,
    this._setReady,
    this._startGame,
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
    on<SetReadyEvent>(_onSetReadyEvent, transformer: droppable());
    on<StartGameEvent>(_onStartGameEvent, transformer: droppable());
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
    final result = await _connectToServer(Params(
      user: event.user,
      server: event.server,
      isLobby: event.isLobby,
    ));
    final newState = await result.fold(
      (failure) async => failure.toState,
      (response) async {
        _messageSub = response.listen((event) {
          if (!isClosed) add(AddMessageFromServerEvent(item: event));
        });
        _connectionSub =
            _listenForserverConnection(event.isLobby).listen((event) {
          if (isClosed) return;
          add(DisconnectFromServerEvent(isLobby: event));
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

  Future<void> _onSetReadyEvent(
    SetReadyEvent event,
    Emitter<ConnectToServerState> emit,
  ) async {
    _setReady(const NoParams());
  }

  Future<void> _onStartGameEvent(
    StartGameEvent event,
    Emitter<ConnectToServerState> emit,
  ) async {
    _startGame(const NoParams());
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
    emit(DisconnectFromServerState(isLobby: event.isLobby));
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
