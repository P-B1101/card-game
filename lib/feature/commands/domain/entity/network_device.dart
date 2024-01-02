import 'package:equatable/equatable.dart';

class NetworkDevice extends Equatable {
  final String id;
  final String name;
  final String ip;
  final bool isServer;
  const NetworkDevice({
    required this.id,
    required this.name,
    required this.ip,
    required this.isServer,
  });

  @override
  List<Object?> get props => [id, name, ip, isServer];
}
