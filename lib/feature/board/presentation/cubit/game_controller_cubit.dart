import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/enum.dart';
import '../../../cards/domain/entity/card.dart';
import '../../../cards/manager/card_manager.dart';

part 'game_controller_state.dart';

@injectable
class GameControllerCubit extends Cubit<GameControllerState> {
  GameControllerCubit() : super(GameControllerState.init());

  void loadingDone() => emit(state.loadingDone());

  void shuffelingDone() => emit(state.shuffelingDone());
}
