import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../repository_manager/repository_manager.dart';
import '../../../user/domain/entity/user.dart';
import '../../domain/repository/commands_repository.dart';
import '../data_source/commands_data_source.dart';

@LazySingleton(as: CommandsRepository)
class CommandsRepositoryImpl implements CommandsRepository {
  final CommandsDataSource dataSource;
  final RepositoryHelper repositoryHelper;

  const CommandsRepositoryImpl({
    required this.dataSource,
    required this.repositoryHelper,
  });

  @override
  Future<Either<Failure, void>> connectToServer(User user) =>
      repositoryHelper.tryToLoad(() => dataSource.connectToServer(user));

  @override
  Future<Either<Failure, void>> createServer() =>
      repositoryHelper.tryToLoad(() => dataSource.createServer());
}
