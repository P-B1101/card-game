import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/use_case/use_case.dart';
import '../../domain/entity/network_device.dart';
import '../../domain/use_case/get_players.dart';

part 'network_device_event.dart';
part 'network_device_state.dart';

@injectable
class NetworkDeviceBloc extends Bloc<NetworkDeviceEvent, NetworkDeviceState> {
  final GetPlayers _getPlayers;
  NetworkDeviceBloc(this._getPlayers) : super(NetworkDeviceInitial()) {
    on<GetNetworkDeviceEvent>(_onGetNetworkDeviceEvent);
    on<AddNetworkDeviceEvent>(_onAddNetworkDeviceEvent);
  }
  StreamSubscription? _sub;

  Future<void> _onGetNetworkDeviceEvent(
    GetNetworkDeviceEvent event,
    Emitter<NetworkDeviceState> emit,
  ) async {
    final result = await _getPlayers(const NoParams());
    await result.fold(
      (failure) async {
        await Future.delayed(const Duration(milliseconds: 500));
        add(GetNetworkDeviceEvent());
      },
      (response) async {
        _sub = response.listen((event) {
          add(AddNetworkDeviceEvent(items: event));
        });
      },
    );
  }

  Future<void> _onAddNetworkDeviceEvent(
    AddNetworkDeviceEvent event,
    Emitter<NetworkDeviceState> emit,
  ) async {
    emit(AddNetworkDeviceState(items: event.items));
  }

  @override
  Future<void> close() {
    _sub?.cancel();
    return super.close();
  }
}
