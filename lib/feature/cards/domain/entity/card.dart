import 'package:equatable/equatable.dart';

import '../../../../core/utils/enum.dart';
import '../../../user/domain/entity/user.dart';

class MCard extends Equatable {
  final CardName name;
  final CardType type;
  final User? owner;
  const MCard({
    required this.name,
    required this.owner,
    required this.type,
  });

  @override
  List<Object?> get props => [name, type, owner];

  int get score => switch (name) {
        CardName.ace => 13,
        CardName.two => 1,
        CardName.three => 2,
        CardName.four => 3,
        CardName.five => 4,
        CardName.six => 5,
        CardName.seven => 6,
        CardName.eight => 7,
        CardName.nine => 8,
        CardName.ten => 9,
        CardName.jack => 10,
        CardName.queen => 11,
        CardName.king => 12,
      };

  factory MCard.init({
    required CardName name,
    required CardType type,
  }) =>
      MCard(name: name, owner: null, type: type);
}
