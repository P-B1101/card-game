import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../../../user/domain/entity/user.dart';
import '../repository/commands_repository.dart';

@lazySingleton
class SendMessage extends UseCase<void, Params> {
  final CommandsRepository repository;
  const SendMessage({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(Params param) =>
      repository.sendMessage(message: param.message, user: param.user);
}

class Params extends NoParams {
  final String message;
  final User user;

  const Params({
    required this.message,
    required this.user,
  });

  @override
  List<Object?> get props => [user, message];
}
