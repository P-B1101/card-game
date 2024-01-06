part of 'start_game_cubit.dart';

class StartGameState extends Equatable {
  final int countDown;
  final bool isGameStarted;
  const StartGameState({
    required this.countDown,
    required this.isGameStarted,
  });

  @override
  List<Object> get props => [countDown, isGameStarted];

  factory StartGameState.init() => const StartGameState(
        countDown: Utils.maxCountDown,
        isGameStarted: false,
      );

  StartGameState copyWith({
    int? countDown,
  }) =>
      StartGameState(
        countDown: countDown ?? this.countDown,
        isGameStarted: isGameStarted,
      );

  StartGameState count() => StartGameState(
        countDown: countDown - 1,
        isGameStarted: countDown <= 4,
      );
}
