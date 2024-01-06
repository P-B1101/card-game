import 'package:card_game/core/manager/network_manager.dart';
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
  final NetworkManager networkManager;

  const CommandsRepositoryImpl({
    required this.dataSource,
    required this.repositoryHelper,
    required this.networkManager,
  });

  @override
  Future<Either<Failure, Stream<ServerMessage>>> connectToServer(
    User user,
    NetworkDevice? server,
    bool isLobby,
  ) =>
      repositoryHelper
          .tryToLoad(() => dataSource.connectToServer(user, server, isLobby));

  @override
  Future<Either<Failure, void>> createServer(
    User user,
    bool isLobby,
  ) =>
      repositoryHelper.tryToLoad(() => dataSource.createServer(user, isLobby));

  @override
  Future<Either<Failure, void>> closeServer(User user, bool isLobby) =>
      repositoryHelper.tryToLoad(() => dataSource.closeServer(user, isLobby));

  @override
  Future<Either<Failure, void>> disconnectFromServer(User user) =>
      repositoryHelper.tryToLoad(() => dataSource.disconnectFromServer(user));

  @override
  Future<Either<Failure, void>> sendMessage({
    required User user,
    required String message,
  }) =>
      repositoryHelper.tryToLoad(
          () async => dataSource.sendMessage(user: user, message: message));

  @override
  Future<Either<Failure, List<NetworkDevice>>> getServers(bool useCachedData) =>
      repositoryHelper.tryToLoad(() => dataSource.getServers(useCachedData));

  @override
  Future<Either<Failure, Stream<List<NetworkDevice>>>> getPlayers() =>
      repositoryHelper.tryToLoad(() => dataSource.getPlayers());

  @override
  Stream<bool> listenForServerConnection(bool isLobby) =>
      dataSource.listenForServerConnection(isLobby);

  @override
  Future<Either<Failure, void>> setReady() => repositoryHelper.tryToLoad(
        () async {
          final ip = await networkManager.getMyIp();
          return dataSource.setReady(ip);
        },
      );

  @override
  Future<Either<Failure, void>> startGame() => repositoryHelper.tryToLoad(
        () async => dataSource.startGame(),
      );
}
