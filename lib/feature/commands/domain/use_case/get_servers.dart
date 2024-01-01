import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../entity/network_device.dart';
import '../repository/commands_repository.dart';

@lazySingleton
class GetServers extends UseCase<List<NetworkDevice>, NoParams> {
  final CommandsRepository repository;
  const GetServers({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<NetworkDevice>>> call(NoParams param) =>
      repository.getServers();
}
