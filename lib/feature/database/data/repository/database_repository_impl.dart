import 'package:card_game/core/manager/network_manager.dart';
import 'package:card_game/feature/user/domain/entity/user.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repository/database_repository.dart';
import '../data_source/database_data_source.dart';

@LazySingleton(as: DatabaseRepository)
class DatabaseRepositoryImpl implements DatabaseRepository {
  final DataBaseDataSource dataSource;
  final NetworkManager networkManager;

  const DatabaseRepositoryImpl({
    required this.dataSource,
    required this.networkManager,
  });

  @override
  Future<void> saveUsername(String username) =>
      dataSource.saveUsername(username);

  @override
  Future<User?> getUser() async {
    try {
      final ip = await networkManager.getMyIp();
      return User(
        username: dataSource.getUsername(),
        ip: ip,
      );
    } catch (error) {
      debugPrint(error.toString());
      return null;
    }
  }
}
