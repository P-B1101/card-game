import 'package:card_game/feature/user/domain/entity/user.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../repository/commands_repository.dart';

@lazySingleton
class CloseServer extends UseCase<void, Params> {
  final CommandsRepository repository;
  const CloseServer({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(Params param) =>
      repository.closeServer(param.user, param.isLobby);
}

class Params extends NoParams {
  final User user;
  final bool isLobby;
  const Params({
    required this.user,
    required this.isLobby,
  });

  @override
  List<Object?> get props => [user];
}
