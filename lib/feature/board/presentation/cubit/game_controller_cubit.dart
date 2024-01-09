import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/enum.dart';
import '../../../../core/utils/extensions.dart';
import '../../../cards/domain/entity/card.dart';
import '../../../cards/manager/card_manager.dart';
import '../../../commands/domain/entity/network_device.dart';
import '../../../user/domain/entity/user.dart';

part 'game_controller_state.dart';

@injectable
class GameControllerCubit extends Cubit<GameControllerState> {
  GameControllerCubit() : super(GameControllerState.init());

  void initPlayers(List<NetworkDevice> items) {
    final p1 = items.elementAtOrNull(0);
    final p2 = items.elementAtOrNull(1);
    final p3 = items.elementAtOrNull(2);
    final p4 = items.elementAtOrNull(3);
    final rulerIndex = Random().nextInt(4);
    emit(state.withPlayers(
      p1: p1 == null ? null : User.fromNetworkDevice(p1, rulerIndex == 0),
      p2: p2 == null ? null : User.fromNetworkDevice(p2, rulerIndex == 1),
      p3: p3 == null ? null : User.fromNetworkDevice(p3, rulerIndex == 2),
      p4: p4 == null ? null : User.fromNetworkDevice(p4, rulerIndex == 3),
    ));
  }

  // void dealToP1() => emit(state.dealToP1());

  // void dealToP2() => emit(state.dealToP2());

  // void dealToP3() => emit(state.dealToP3());

  // void dealToP4() => emit(state.dealToP4());

  void loadingDone() => emit(state.loadingDone());

  void shuffelingDone() => emit(state.shuffelingDone());

  void dealingP1() async {
    if (state.isDealing) return;
    emit(state.dealingP1());
    await Future.delayed(const Duration(milliseconds: 500));
    emit(state.dealToP1());
  }

  // void dealingP2() => emit(state.dealingP2());

  // void dealingP3() => emit(state.dealingP3());

  // void dealingP4() => emit(state.dealingP4());
}
