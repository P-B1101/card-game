import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/utils.dart';

part 'start_game_state.dart';

@injectable
class StartGameCubit extends Cubit<StartGameState> {
  StartGameCubit() : super(StartGameState.init());

  Future<void> startCountDown() async {
    await Future.delayed(const Duration(seconds: 1));
    if (state.countDown <= 1) return;
    emit(state.count());
    return startCountDown();
  }
}
