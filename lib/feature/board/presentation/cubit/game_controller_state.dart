part of 'game_controller_cubit.dart';

class GameControllerState extends Equatable {
  final GameStep step;
  final List<MCard> cards;
  final ({User user, List<MCard> cards})? p1;
  final ({User user, List<MCard> cards})? p2;
  final ({User user, List<MCard> cards})? p3;
  final ({User user, List<MCard> cards})? p4;

  const GameControllerState({
    required this.step,
    required this.cards,
    required this.p1,
    required this.p2,
    required this.p3,
    required this.p4,
  });

  @override
  List<Object?> get props => [step, cards, p1, p2, p3, p4];

  factory GameControllerState.init() => GameControllerState(
        step: GameStep.loading,
        cards: CardManager.getNewRandomCards,
        p1: null,
        p2: null,
        p3: null,
        p4: null,
      );

  GameControllerState withPlayers({
    required User? p1,
    required User? p2,
    required User? p3,
    required User? p4,
  }) =>
      GameControllerState(
        step: step,
        cards: cards,
        p1: p1 == null ? null : (user: p1, cards: []),
        p2: p2 == null ? null : (user: p2, cards: []),
        p3: p3 == null ? null : (user: p3, cards: []),
        p4: p4 == null ? null : (user: p4, cards: []),
      );

  GameControllerState dealToP1() {
    if (step != GameStep.dealingP1) return this;
    final items = List.of(cards);
    final p1Cards = (p1?.cards ?? []);
    p1Cards.addAll(items.getLastFour);
    return GameControllerState(
      step: GameStep.dealingP2,
      cards: items,
      p1: p1?.copyWith(cards: p1Cards),
      p2: p2,
      p3: p3,
      p4: p4,
    );
  }

  GameControllerState dealToP2() {
    if (step != GameStep.dealingP2) return this;
    final items = List.of(cards);
    final p2Cards = (p2?.cards ?? []);
    p2Cards.addAll(items.getLastFour);
    return GameControllerState(
      step: GameStep.dealingP3,
      cards: items,
      p1: p1,
      p2: p2?.copyWith(cards: p2Cards),
      p3: p3,
      p4: p4,
    );
  }

  GameControllerState dealToP3() {
    if (step != GameStep.dealingP3) return this;
    final items = List.of(cards);
    final p3Cards = (p3?.cards ?? []);
    p3Cards.addAll(items.getLastFour);
    return GameControllerState(
      step: GameStep.dealingP4,
      cards: items,
      p1: p1,
      p2: p2,
      p3: p3?.copyWith(cards: p3Cards),
      p4: p4,
    );
  }

  GameControllerState dealToP4() {
    if (step != GameStep.dealingP4) return this;
    final items = List.of(cards);
    final p4Cards = (p4?.cards ?? []);
    p4Cards.addAll(items.getLastFour);
    return GameControllerState(
      step: GameStep.p1,
      cards: items,
      p1: p1,
      p2: p2,
      p3: p3,
      p4: p4?.copyWith(cards: p4Cards),
    );
  }

  GameControllerState loadingDone() => GameControllerState(
        step: GameStep.shuffeling,
        cards: cards,
        p1: p1,
        p2: p2,
        p3: p3,
        p4: p4,
      );

  GameControllerState shuffelingDone() => GameControllerState(
        step: GameStep.shuffelingDone,
        cards: cards,
        p1: p1,
        p2: p2,
        p3: p3,
        p4: p4,
      );
  GameControllerState dealingP1() => GameControllerState(
        step: GameStep.dealingP1,
        cards: cards,
        p1: p1,
        p2: p2,
        p3: p3,
        p4: p4,
      );

  // GameControllerState dealingP2() => GameControllerState(
  //       step: GameStep.dealingP2,
  //       cards: cards,
  //       p1: p1,
  //       p2: p2,
  //       p3: p3,
  //       p4: p4,
  //     );

  // GameControllerState dealingP3() => GameControllerState(
  //       step: GameStep.dealingP3,
  //       cards: cards,
  //       p1: p1,
  //       p2: p2,
  //       p3: p3,
  //       p4: p4,
  //     );

  // GameControllerState dealingP4() => GameControllerState(
  //       step: GameStep.dealingP4,
  //       cards: cards,
  //       p1: p1,
  //       p2: p2,
  //       p3: p3,
  //       p4: p4,
  //     );

  GameControllerState copyWith({
    GameStep? step,
  }) =>
      GameControllerState(
        step: step ?? this.step,
        cards: cards,
        p1: p1,
        p2: p2,
        p3: p3,
        p4: p4,
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
        GameStep.shuffelingDone => true,
        GameStep.p1 => true,
        GameStep.p2 => true,
        GameStep.p3 => true,
        GameStep.p4 => true,
        GameStep.dealingP1 => true,
        GameStep.dealingP2 => true,
        GameStep.dealingP3 => true,
        GameStep.dealingP4 => true,
        _ => false,
      };
  bool get isDealingP1 => switch (step) {
        GameStep.dealingP1 => true,
        _ => false,
      };

  bool get isDealing => switch (step) {
        GameStep.dealingP1 => true,
        GameStep.dealingP2 => true,
        GameStep.dealingP3 => true,
        GameStep.dealingP4 => true,
        _ => false,
      };

  List<MCard> getCards(NetworkDevice? device) {
    if (device == null) return [];
    if (p1?.user.ip == device.ip) return p1?.cards ?? [];
    if (p2?.user.ip == device.ip) return p2?.cards ?? [];
    if (p3?.user.ip == device.ip) return p3?.cards ?? [];
    if (p4?.user.ip == device.ip) return p4?.cards ?? [];
    return [];
  }
}
