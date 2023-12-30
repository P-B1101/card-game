import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../user/domain/entity/user.dart';
import '../entity/server_message.dart';

abstract class CommandsRepository {
  Future<Either<Failure, Stream<ServerMessage>>> createServer();

  Future<Either<Failure, void>> connectToServer(User user);

  Future<Either<Failure, void>> closeServer();

  Future<Either<Failure, void>> disconnectFromServer(User user);

  Future<Either<Failure, void>> sendMessage({
    required User user,
    required String message,
  });
}
