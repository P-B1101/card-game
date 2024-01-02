import '../../domain/entity/network_device.dart';

class NetworkDeviceModel extends NetworkDevice {
  const NetworkDeviceModel({
    required super.id,
    required super.name,
    required super.ip,
    required super.isServer,
  });

  factory NetworkDeviceModel.fromEntity(NetworkDevice entity) =>
      NetworkDeviceModel(
        id: entity.id,
        name: entity.name,
        ip: entity.ip,
        isServer: entity.isServer,
      );

  factory NetworkDeviceModel.fromJson(Map<String, dynamic> json) =>
      NetworkDeviceModel(
        id: json['id'],
        name: json['name'],
        ip: json['ip'],
        isServer: json['isServer'],
      );

  Map<String, dynamic> get toJson => {
        'id': id,
        'name': name,
        'ip': ip,
        'isServer': isServer,
      };
}
