import 'package:card_game/feature/commands/domain/entity/network_device.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../repository_manager/repository_manager.dart';
import '../../../user/domain/entity/user.dart';
import '../../domain/entity/server_message.dart';
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
  Future<Either<Failure, Stream<ServerMessage>>> connectToServer(User user) =>
      repositoryHelper.tryToLoad(() => dataSource.connectToServer(user));

  @override
  Future<Either<Failure, void>> createServer(User user) =>
      repositoryHelper.tryToLoad(() => dataSource.createServer(user));

  @override
  Future<Either<Failure, void>> closeServer(User user) =>
      repositoryHelper.tryToLoad(() => dataSource.closeServer(user));

  @override
  Future<Either<Failure, void>> disconnectFromServer(User user) =>
      repositoryHelper.tryToLoad(() => dataSource.disconnectFromServer(user));

  @override
  Future<Either<Failure, void>> sendMessage({
    required User user,
    required String message,
  }) =>
      repositoryHelper.tryToLoad(
          () => dataSource.sendMessage(user: user, message: message));

  @override
  Future<Either<Failure, Stream<List<NetworkDevice>>>> getPlayers() =>
      repositoryHelper.tryToLoad(() => dataSource.getPlayers());
}
