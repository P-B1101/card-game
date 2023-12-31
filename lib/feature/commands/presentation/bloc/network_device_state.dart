part of 'network_device_bloc.dart';

sealed class NetworkDeviceState extends Equatable {
  final List<NetworkDevice> items;
  const NetworkDeviceState({
    this.items = const [],
  });

  @override
  List<Object> get props => [items];
}

final class NetworkDeviceInitial extends NetworkDeviceState {}

final class NetworkDeviceLoadingState extends NetworkDeviceState {
  const NetworkDeviceLoadingState({
    required super.items,
  });
}

final class AddNetworkDeviceState extends NetworkDeviceState {
  const AddNetworkDeviceState({
    required super.items,
  });
}

final class NetworkDeviceFailureState extends NetworkDeviceState {}
