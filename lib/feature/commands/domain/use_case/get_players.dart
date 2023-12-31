import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../entity/network_device.dart';
import '../repository/commands_repository.dart';

@lazySingleton
class GetPlayers extends UseCase<Stream<List<NetworkDevice>>, NoParams> {
  final CommandsRepository repository;
  const GetPlayers({
    required this.repository,
  });

  @override
  Future<Either<Failure, Stream<List<NetworkDevice>>>> call(NoParams param) =>
      repository.getPlayers();
}
