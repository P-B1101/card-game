part of 'start_game_cubit.dart';

class StartGameState extends Equatable {
  final int countDown;
  final bool isGameStarted;
  final bool isPlayer;
  const StartGameState({
    required this.countDown,
    required this.isGameStarted,
    required this.isPlayer,
  });

  @override
  List<Object> get props => [countDown, isGameStarted, isPlayer];

  factory StartGameState.init() => const StartGameState(
        countDown: Utils.maxCountDown,
        isGameStarted: false,
        isPlayer: false,
      );

  StartGameState copyWith({
    int? countDown,
    bool? isPlayer,
  }) =>
      StartGameState(
        countDown: countDown ?? this.countDown,
        isGameStarted: isGameStarted,
        isPlayer: isPlayer ?? this.isPlayer,
      );

  StartGameState count() => StartGameState(
        countDown: countDown - 1,
        isGameStarted: countDown <= 4,
        isPlayer: isPlayer,
      );
}
