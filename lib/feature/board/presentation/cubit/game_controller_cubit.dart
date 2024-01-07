import 'package:bloc/bloc.dart';
import 'package:card_game/core/utils/enum.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

part 'game_controller_state.dart';

@injectable
class GameControllerCubit extends Cubit<GameControllerState> {
  GameControllerCubit() : super(GameControllerState.init());

  void loadingDone() => emit(state.loadingDone());
}
