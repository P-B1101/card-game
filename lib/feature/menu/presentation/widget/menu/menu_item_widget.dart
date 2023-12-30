import 'package:card_game/core/utils/assets.dart';
import 'package:flutter/material.dart';

class MenuItemWidget extends StatelessWidget {
  final String title;
  final Function() onClick;
  const MenuItemWidget({
    super.key,
    required this.title,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 48,
      margin: const EdgeInsets.symmetric(vertical: 12,horizontal: 24),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: MColors.primaryColor,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(4),
          onTap: onClick,
          child: Center(
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: Fonts.bold700,
                color: MColors.whiteColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
