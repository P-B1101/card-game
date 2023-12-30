import 'package:injectable/injectable.dart';

import '../repository/database_repository.dart';

@lazySingleton
class SaveUsername {
  final DatabaseRepository repository;
  const SaveUsername({
    required this.repository,
  });

  Future<void> call(String username) => repository.saveUsername(username);
}
