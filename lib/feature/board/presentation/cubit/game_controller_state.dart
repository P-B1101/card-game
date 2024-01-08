part of 'game_controller_cubit.dart';

class GameControllerState extends Equatable {
  final GameStep step;
  final List<MCard> cards;
  const GameControllerState({
    required this.step,
    required this.cards,
  });

  @override
  List<Object> get props => [step];

  factory GameControllerState.init() => GameControllerState(
        step: GameStep.loading,
        cards: CardManager.getNewRandomCards,
      );

  GameControllerState loadingDone() => GameControllerState(
        step: GameStep.shuffeling,
        cards: cards,
      );

  GameControllerState shuffelingDone() => GameControllerState(
        step: GameStep.started,
        cards: cards,
      );

  GameControllerState copyWith({
    GameStep? step,
  }) =>
      GameControllerState(
        step: step ?? this.step,
        cards: cards,
      );

  bool get isLoading => switch (step) {
        GameStep.loading => true,
        _ => false,
      };

  bool get isShuffeling => switch (step) {
        GameStep.shuffeling => true,
        _ => false,
      };

  bool get isStarted => switch (step) {
        GameStep.started => true,
        GameStep.p1 => true,
        GameStep.p2 => true,
        GameStep.p3 => true,
        GameStep.p4 => true,
        _ => false,
      };
}
