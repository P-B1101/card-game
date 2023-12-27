import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../user/domain/entity/user.dart';
import '../../domain/use_case/connect_to_server.dart';

part 'connect_to_server_event.dart';
part 'connect_to_server_state.dart';

@injectable
class ConnectToServerBloc
    extends Bloc<ConnectToServerEvent, ConnectToServerState> {
  final ConnectToServer _connectToServer;
  ConnectToServerBloc(this._connectToServer) : super(ConnectToServerInitial()) {
    on<DoConnectToServerEvent>(_onDoConnectToServerEvent,
        transformer: droppable());
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
}

extension FailureToStateExt on Failure {
  ConnectToServerState get toState => switch (this) {
        _ => ConnectToServerFailure(),
      };
}
