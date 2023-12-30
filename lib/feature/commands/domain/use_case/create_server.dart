import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../entity/server_message.dart';
import '../repository/commands_repository.dart';

@lazySingleton
class CreateServer extends UseCase<Stream<ServerMessage>, NoParams> {
  final CommandsRepository repository;
  const CreateServer({
    required this.repository,
  });

  @override
  Future<Either<Failure, Stream<ServerMessage>>> call(NoParams param) =>
      repository.createServer();
}