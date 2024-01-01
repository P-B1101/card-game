import 'package:bloc/bloc.dart';
import 'package:card_game/core/manager/network_manager.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../user/domain/entity/user.dart';
import '../../domain/use_case/get_username.dart';
import '../../domain/use_case/save_username.dart';

part 'username_state.dart';

@injectable
class UsernameCubit extends Cubit<UsernameState> {
  final SaveUsername _saveUsername;
  final NetworkManager _networkManager;
  UsernameCubit(
    this._saveUsername,
    this._networkManager,
    GetUsername getUsername,
  ) : super(() {
          final user = getUsername();
          return UsernameState(
            user: user ?? User.empty(),
            hasUser: user != null,
          );
        }());

  Future<User> saveUser(String username) async {
    _saveUsername(username);
    final ip = await _networkManager.getMyIp();
    final user = User(username: username, ip: ip);
    emit(UsernameState(user: user, hasUser: true));
    return user;
  }
}
