import '../../domain/entity/network_device.dart';

class NetworkDeviceModel extends NetworkDevice {
  const NetworkDeviceModel({
    required super.id,
    required super.name,
  });

  factory NetworkDeviceModel.fromEntity(NetworkDevice entity) =>
      NetworkDeviceModel(
        id: entity.id,
        name: entity.name,
      );

  factory NetworkDeviceModel.fromJson(Map<String, dynamic> json) =>
      NetworkDeviceModel(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> get toJson => {
        'id': id,
        'name': name,
      };
}
