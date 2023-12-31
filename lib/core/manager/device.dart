import 'package:equatable/equatable.dart';

class Device extends Equatable {
  final String name;
  final String ip;
  
  const Device({
    required this.name,
    required this.ip,
  });

  @override
  List<Object?> get props => [name,ip];
}