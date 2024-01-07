part of 'game_controller_cubit.dart';

class GameControllerState extends Equatable {
  final GameStep step;
  const GameControllerState({
    required this.step,
  });

  @override
  List<Object> get props => [step];

  factory GameControllerState.init() =>
      const GameControllerState(step: GameStep.loading);

  GameControllerState loadingDone() =>
      const GameControllerState(step: GameStep.shuffeling);

  GameControllerState copyWith({
    GameStep? step,
  }) =>
      GameControllerState(step: step ?? this.step);

  bool get isLoading => switch (step) {
        GameStep.loading => true,
        _ => false,
      };
}
