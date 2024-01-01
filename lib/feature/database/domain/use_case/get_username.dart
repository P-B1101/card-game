import 'package:injectable/injectable.dart';

import '../repository/database_repository.dart';
import '../../../user/domain/entity/user.dart';

@lazySingleton
class GetUsername {
  final DatabaseRepository repository;
  const GetUsername({
    required this.repository,
  });

  Future<User?> call() => repository.getUser();
}
