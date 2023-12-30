import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

import '../../../user/domain/entity/user.dart';
import '../../domain/use_case/get_username.dart';
import '../../domain/use_case/save_username.dart';

part 'username_state.dart';

@injectable
class UsernameCubit extends Cubit<UsernameState> {
  final SaveUsername _saveUsername;
  UsernameCubit(
    this._saveUsername,
    GetUsername getUsername,
  ) : super(() {
          final user = getUsername();
          return UsernameState(
            user: user ?? User.empty(),
            hasUser: user != null,
          );
        }());

  User saveUser(String username) {
    _saveUsername(username);
    final user = User(username: username);
    emit(UsernameState(user: user, hasUser: true));
    return user;
  }
}
