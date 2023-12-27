import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../../domain/use_case/create_server.dart';

part 'create_server_event.dart';
part 'create_server_state.dart';

@injectable
class CreateServerBloc extends Bloc<CreateServerEvent, CreateServerState> {
  final CreateServer _createServer;
  CreateServerBloc(this._createServer) : super(CreateServerInitial()) {
    on<DoCreateServerEvent>(_onDoCreateServerEvent, transformer: droppable());
  }

  Future<void> _onDoCreateServerEvent(
    DoCreateServerEvent event,
    Emitter<CreateServerState> emit,
  ) async {
    emit(CreateServerLoading());
    final result = await _createServer(const NoParams());
    final newState = await result.fold(
      (failure) async => failure.toState,
      (response) async => CreateServerSuccess(),
    );
    emit(newState);
  }
}

extension FailureToStateExt on Failure {
  CreateServerState get toState => switch (this) {
        _ => CreateServerFailure(),
      };
}
