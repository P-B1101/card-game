import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../user/domain/entity/user.dart';
import '../../domain/use_case/close_server.dart' as cls;
import '../../domain/use_case/connect_to_server.dart';
import '../../domain/use_case/send_message.dart' as send;

part 'connect_to_server_event.dart';
part 'connect_to_server_state.dart';

@injectable
class ConnectToServerBloc
    extends Bloc<ConnectToServerEvent, ConnectToServerState> {
  final ConnectToServer _connectToServer;
  final cls.CloseServer _closeServer;
  final send.SendMessage _sendMessage;
  ConnectToServerBloc(
    this._connectToServer,
    this._closeServer,
    this._sendMessage,
  ) : super(ConnectToServerInitial()) {
    on<DoConnectToServerEvent>(
      _onDoConnectToServerEvent,
      transformer: droppable(),
    );
    on<SendMessageToServerEvent>(
      _onSendMessageToServerEvent,
      transformer: droppable(),
    );
  }

  Future<void> _onDoConnectToServerEvent(
    DoConnectToServerEvent event,
    Emitter<ConnectToServerState> emit,
  ) async {
    emit(ConnectToServerLoading());
    final result = await _connectToServer(Params(user: event.user));
    final newState = await result.fold(
      (failure) async => failure.toState,
      (response) async => ConnectToServerSuccess(),
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
      (response) async => ConnectToServerSuccess(),
    );
    emit(newState);
  }
}

extension FailureToStateExt on Failure {
  ConnectToServerState get toState => switch (this) {
        _ => ConnectToServerFailure(),
      };
}
