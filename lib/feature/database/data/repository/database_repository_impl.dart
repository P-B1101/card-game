import 'package:injectable/injectable.dart';

import '../../domain/repository/database_repository.dart';
import '../data_source/database_data_source.dart';

@LazySingleton(as: DatabaseRepository)
class DatabaseRepositoryImpl implements DatabaseRepository {
  final DataBaseDataSource dataSource;

  const DatabaseRepositoryImpl({
    required this.dataSource,
  });
}
