import '../../domain/entity/user.dart';

class UserModel extends User {
  const UserModel({
    required super.ip,
    required super.username,
  });

  factory UserModel.fromEntity(User entity) => UserModel(
        ip: entity.ip,
        username: entity.username,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        ip: json['ip'],
        username: json['username'],
      );

  Map<String, dynamic> get toJson => {
        'ip': ip,
        'username': username,
      };
}
