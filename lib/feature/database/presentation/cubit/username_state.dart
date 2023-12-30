part of 'username_cubit.dart';

class UsernameState extends Equatable {
  final bool hasUser;
  final User user;
  const UsernameState({
    required this.user,
    required this.hasUser,
  });

  @override
  List<Object> get props => [user, hasUser];
}
