part of 'players_bloc.dart';

sealed class PlayersEvent extends Equatable {
  const PlayersEvent();

  @override
  List<Object> get props => [];
}

final class GetPlayersEvent extends PlayersEvent {}

final class AddPlayersEvent extends PlayersEvent {
  final List<NetworkDevice> items;
  const AddPlayersEvent({
    required this.items,
  });

  @override
  List<Object> get props => [items];
}
