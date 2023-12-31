import 'package:card_game/feature/user/domain/entity/user.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repository/database_repository.dart';
import '../data_source/database_data_source.dart';

@LazySingleton(as: DatabaseRepository)
class DatabaseRepositoryImpl implements DatabaseRepository {
  final DataBaseDataSource dataSource;

  const DatabaseRepositoryImpl({
    required this.dataSource,
  });

  @override
  Future<void> saveUsername(String username) =>
      dataSource.saveUsername(username);

  @override
  User? getUser() {
    try {
      // return User(username: dataSource.getUsername());
      return null;
    } catch (error) {
      debugPrint(error.toString());
      return null;
    }
  }
}
