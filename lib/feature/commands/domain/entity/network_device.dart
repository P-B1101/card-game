import 'package:equatable/equatable.dart';

class NetworkDevice extends Equatable {
  final String id;
  final String name;
  final String ip;
  final bool isServer;
  final bool isReady;
  final String serverIp;
  const NetworkDevice({
    required this.id,
    required this.name,
    required this.ip,
    required this.isServer,
    required this.isReady,
    required this.serverIp,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        ip,
        isServer,
        isReady,
        serverIp,
      ];

  NetworkDevice toggleReady() => NetworkDevice(
        id: id,
        name: name,
        ip: ip,
        isServer: isServer,
        isReady: !isReady,
        serverIp: serverIp,
      );
}
