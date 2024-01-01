part of 'network_device_bloc.dart';

sealed class NetworkDeviceEvent extends Equatable {
  const NetworkDeviceEvent();

  @override
  List<Object> get props => [];
}

final class GetNetworkDeviceEvent extends NetworkDeviceEvent {}

// final class AddNetworkDeviceEvent extends NetworkDeviceEvent {
//   final List<NetworkDevice> items;
//   const AddNetworkDeviceEvent({
//     required this.items,
//   });

//   @override
//   List<Object> get props => [items];
// }
