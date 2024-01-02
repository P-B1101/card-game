import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/use_case/use_case.dart';
import '../../domain/entity/network_device.dart';
import '../../domain/use_case/get_players.dart';

part 'players_event.dart';
part 'players_state.dart';

@injectable
class PlayersBloc extends Bloc<PlayersEvent, PlayersState> {
  final GetPlayers _getPlayers;
  PlayersBloc(this._getPlayers) : super(PlayersInitial()) {
    on<GetPlayersEvent>(_onGetPlayersEvent);
    on<AddPlayersEvent>(_onAddPlayersEvent);
  }
  StreamSubscription? _sub;

  Future<void> _onGetPlayersEvent(
    GetPlayersEvent event,
    Emitter<PlayersState> emit,
  ) async {
    final result = await _getPlayers(const NoParams());
    await result.fold(
      (failure) async {
        await Future.delayed(const Duration(milliseconds: 500));
        add(GetPlayersEvent());
      },
      (response) async {
        _sub = response.listen((event) {
          if (!isClosed) add(AddPlayersEvent(items: event));
        });
      },
    );
  }

  Future<void> _onAddPlayersEvent(
    AddPlayersEvent event,
    Emitter<PlayersState> emit,
  ) async {
    emit(AddPlayerState(items: event.items));
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
