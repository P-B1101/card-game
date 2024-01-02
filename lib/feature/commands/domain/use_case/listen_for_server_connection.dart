import 'package:injectable/injectable.dart';

import '../repository/commands_repository.dart';

@lazySingleton
class ListenForserverConnection {
  final CommandsRepository repository;
  const ListenForserverConnection({
    required this.repository,
  });

  Stream<bool> call() => repository.listenForServerConnection();
}