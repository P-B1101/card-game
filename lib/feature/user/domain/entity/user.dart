import 'package:card_game/feature/commands/domain/entity/network_device.dart';
import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String username;
  final String ip;
  final bool isRuler;
  const User({
    required this.username,
    required this.ip,
    required this.isRuler,
  });

  @override
  List<Object?> get props => [username, ip, isRuler];

  factory User.empty() => const User(
        username: '',
        ip: '',
        isRuler: false,
      );

  factory User.fromNetworkDevice(NetworkDevice device, bool isRuler) => User(
        username: device.name,
        ip: device.ip,
        isRuler: isRuler,
      );

  User updateRuler(bool isRuler) =>
      User(username: username, ip: ip, isRuler: isRuler);
}
