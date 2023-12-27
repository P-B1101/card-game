import 'package:card_game/core/error/failures.dart';
import 'package:dartz/dartz.dart';

import '../../../user/domain/entity/user.dart';

abstract class CommandsRepository {
  Future<Either<Failure, void>> createServer();

  Future<Either<Failure, void>> connectToServer(User user);
}
