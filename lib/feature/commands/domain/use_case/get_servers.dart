import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/use_case/use_case.dart';
import '../entity/network_device.dart';
import '../repository/commands_repository.dart';

@lazySingleton
class GetServers extends UseCase<List<NetworkDevice>, Params> {
  final CommandsRepository repository;
  const GetServers({
    required this.repository,
  });

  @override
  Future<Either<Failure, List<NetworkDevice>>> call(Params param) =>
      repository.getServers(param.useCachedData);
}

class Params extends NoParams {
  final bool useCachedData;
  const Params({
    required this.useCachedData,
  });

  @override
  List<Object?> get props => [useCachedData];
}
