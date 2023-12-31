import 'package:equatable/equatable.dart';

class NetworkDevice extends Equatable {
  final String id;
  final String name;
  const NetworkDevice({
    required this.id,
    required this.name,
  });

  @override
  List<Object?> get props => [id, name];
}
