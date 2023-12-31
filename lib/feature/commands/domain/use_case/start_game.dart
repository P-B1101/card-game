import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../repository/commands_repository.dart';

@lazySingleton
class StartGame extends UseCase<void, NoParams> {
  final CommandsRepository repository;
  const StartGame({
    required this.repository,
  });

  @override
  Future<Either<Failure, void>> call(NoParams param) => repository.startGame();
}
