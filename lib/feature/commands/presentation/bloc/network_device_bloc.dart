import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entity/network_device.dart';
import '../../domain/use_case/get_servers.dart';

part 'network_device_event.dart';
part 'network_device_state.dart';

@injectable
class NetworkDeviceBloc extends Bloc<NetworkDeviceEvent, NetworkDeviceState> {
  final GetServers _getServers;
  NetworkDeviceBloc(this._getServers) : super(NetworkDeviceInitial()) {
    on<GetNetworkDeviceEvent>(_onGetNetworkDeviceEvent,
        transformer: restartable());
    // on<AddNetworkDeviceEvent>(_onAddNetworkDeviceEvent);
  }

  Future<void> _onGetNetworkDeviceEvent(
    GetNetworkDeviceEvent event,
    Emitter<NetworkDeviceState> emit,
  ) async {
    emit(NetworkDeviceLoadingState(items: state.items));
    final result = await _getServers(Params(useCachedData: event.useCachedData));
    final newState = await result.fold(
      (failure) async => NetworkDeviceFailureState(),
      (response) async => AddNetworkDeviceState(items: response),
    );
    emit(newState);
  }

  // Future<void> _onAddNetworkDeviceEvent(
  //   AddNetworkDeviceEvent event,
  //   Emitter<NetworkDeviceState> emit,
  // ) async {
  //   emit(AddNetworkDeviceState(items: event.items));
  // }
}
