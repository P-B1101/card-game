import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String username;
  final String ip;
  const User({
    required this.username,
    required this.ip,
  });

  @override
  List<Object?> get props => [username, ip];
  factory User.empty() => const User(username: '', ip: '');
}
