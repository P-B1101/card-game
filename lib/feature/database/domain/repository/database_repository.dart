import 'package:card_game/feature/user/domain/entity/user.dart';

abstract class DatabaseRepository {
  Future<void> saveUsername(String username);

  User? getUser();
}
