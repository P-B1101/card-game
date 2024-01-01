import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
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
  ConnectToServerBloc(
    this._connectToServer,
    this._sendMessage,
    this._disconnectFromServer,
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
  }
  StreamSubscription? _sub;
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
        _sub = response.listen((event) {
          add(AddMessageFromServerEvent(item: event));
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

  @override
  Future<void> close() {
    _sub?.cancel();
    if (_user != null) _disconnectFromServer(dc.Params(user: _user!));
    return super.close();
  }
}

extension FailureToStateExt on Failure {
  ConnectToServerState get toState => switch (this) {
        _ => ConnectToServerFailure(),
      };
}
