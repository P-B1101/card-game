part of 'players_bloc.dart';

sealed class PlayersState extends Equatable {
  final List<NetworkDevice> items;
  const PlayersState({
    this.items = const [],
  });
  
  @override
  List<Object> get props => [items];
}

final class PlayersInitial extends PlayersState {}

final class AddPlayerState extends PlayersState {
  const AddPlayerState({
    required super.items,
  });
}