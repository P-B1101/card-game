import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../../../user/domain/entity/user.dart';
import '../entity/server_message.dart';
import '../repository/commands_repository.dart';

@lazySingleton
class ConnectToServer extends UseCase<Stream<ServerMessage>, Params> {
  final CommandsRepository repository;
  const ConnectToServer({
    required this.repository,
  });

  @override
  Future<Either<Failure, Stream<ServerMessage>>> call(Params param) =>
      repository.connectToServer(param.user);
}

class Params extends NoParams {
  final User user;
  const Params({
    required this.user,
  });

  @override
  List<Object?> get props => [user];
}