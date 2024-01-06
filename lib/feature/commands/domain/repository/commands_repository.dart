import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../user/domain/entity/user.dart';
import '../entity/network_device.dart';
import '../entity/server_message.dart';

abstract class CommandsRepository {
  Future<Either<Failure, void>> createServer(
    User user,
    bool isLobby,
  );

  Future<Either<Failure, Stream<ServerMessage>>> connectToServer(
    User user,
    NetworkDevice? server,
    bool isLobby,
  );

  Future<Either<Failure, void>> closeServer(User user, bool isLobby);

  Future<Either<Failure, void>> disconnectFromServer(User user);

  Future<Either<Failure, void>> sendMessage({
    required User user,
    required String message,
  });

  Future<Either<Failure, List<NetworkDevice>>> getServers(bool useCachedData);

  Future<Either<Failure, Stream<List<NetworkDevice>>>> getPlayers();

  Stream<bool> listenForServerConnection(bool isLobby);

  Future<Either<Failure, void>> setReady();

  Future<Either<Failure, void>> startGame();
}
