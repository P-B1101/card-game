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
  final GetUsername _getUsername;
  UsernameCubit(
    this._saveUsername,
    this._networkManager,
    this._getUsername,
  ) : super(UsernameState(user: User.empty(), hasUser: false));

  void getUser() async {
    final user = await _getUsername();
    if (user == null) return;
    emit(UsernameState(user: user, hasUser: true));
  }

  Future<User> saveUser(String username) async {
    _saveUsername(username);
    final ip = await _networkManager.getMyIp();
    final user = User(username: username, ip: ip, isRuler: false);
    emit(UsernameState(user: user, hasUser: true));
    return user;
  }
}
