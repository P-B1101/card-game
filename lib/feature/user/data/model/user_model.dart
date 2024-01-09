import '../../domain/entity/user.dart';

class UserModel extends User {
  const UserModel({
    required super.ip,
    required super.username,
    required super.isRuler,
  });

  factory UserModel.fromEntity(User entity) => UserModel(
        ip: entity.ip,
        username: entity.username,
        isRuler: entity.isRuler,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        ip: json['ip'],
        username: json['username'],
        isRuler: json['isRuler'],
      );

  Map<String, dynamic> get toJson => {
        'ip': ip,
        'username': username,
        'isRuler': isRuler,
      };
}
