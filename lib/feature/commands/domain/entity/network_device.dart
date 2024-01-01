import 'package:equatable/equatable.dart';

class NetworkDevice extends Equatable {
  final String id;
  final String name;
  final String ip;
  const NetworkDevice({
    required this.id,
    required this.name,
    required this.ip,
  });

  @override
  List<Object?> get props => [id, name, ip];
}
