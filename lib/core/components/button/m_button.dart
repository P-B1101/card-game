import 'package:flutter/material.dart';

import '../../utils/assets.dart';
import '../../utils/enum.dart';
import '../../utils/utils.dart';
import '../loading/adaptive_loading_widget.dart';

class MButtonWidget extends StatelessWidget {
  final Function() onClick;
  final String title;
  final bool isEnable;
  final bool enableClickWhenDisable;
  final FontWeight? textWeight;
  final double textSize;
  final bool isLoading;
  final double? width;
  final ButtonType type;
  final Widget? child;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final Color? color;
  final Color? textColor;
  final Color? disableTextColor;
  final bool isUnderline;
  final double? loadingStroke;
  final double? loadingSize;
  const MButtonWidget({
    super.key,
    required this.onClick,
    required this.title,
    this.isEnable = true,
    this.enableClickWhenDisable = true,
    this.textWeight,
    this.isLoading = false,
    this.width,
    this.type = ButtonType.fill,
    this.child,
    this.height = 48,
    this.padding,
    this.color,
    this.textColor,
    this.disableTextColor,
    this.isUnderline = false,
    this.textSize = 16,
    this.loadingStroke,
    this.loadingSize,
  });

  factory MButtonWidget.outline({
    required Function() onClick,
    required String title,
    bool isEnable = true,
    bool enableClickWhenDisable = true,
    FontWeight? textWeight,
    bool isLoading = false,
    EdgeInsetsGeometry? padding,
    double? width,
    double textSize = 16,
    double? height = 48,
  }) =>
      MButtonWidget(
        onClick: onClick,
        title: title,
        enableClickWhenDisable: enableClickWhenDisable,
        isEnable: isEnable,
        isLoading: isLoading,
        type: ButtonType.outline,
        textWeight: textWeight,
        width: width,
        padding: padding,
        textSize: textSize,
        height: height,
      );

  factory MButtonWidget.text({
    required Function() onClick,
    required String title,
    bool isEnable = true,
    bool enableClickWhenDisable = true,
    FontWeight? textWeight,
    bool isLoading = false,
    double? width,
    EdgeInsetsGeometry? padding,
    bool isUnderline = false,
  }) =>
      MButtonWidget(
        onClick: onClick,
        title: title,
        enableClickWhenDisable: enableClickWhenDisable,
        isEnable: isEnable,
        isLoading: isLoading,
        type: ButtonType.text,
        textWeight: textWeight,
        width: width,
        padding: padding,
        isUnderline: isUnderline,
      );

  factory MButtonWidget.textWithIcon(
          {required Function() onClick,
          required Widget child,
          bool isEnable = true,
          bool enableClickWhenDisable = true,
          FontWeight? textWeight,
          bool isLoading = false,
          double? width,
          EdgeInsetsGeometry? padding}) =>
      MButtonWidget(
        onClick: onClick,
        title: '',
        enableClickWhenDisable: enableClickWhenDisable,
        isEnable: isEnable,
        isLoading: isLoading,
        type: ButtonType.textAndIcon,
        textWeight: textWeight,
        width: width,
        padding: padding,
        child: child,
      );

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: UiUtils.duration,
      curve: UiUtils.curve,
      opacity: isEnable ? 1 : .5,
      child: Container(
        width: width,
        height: () {
          switch (type) {
            case ButtonType.textAndIcon:
            case ButtonType.text:
              return null;
            case ButtonType.fill:
            case ButtonType.outline:
              return height;
          }
        }(),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: () {
            switch (type) {
              case ButtonType.fill:
                return color ?? MColors.primaryColor;
              case ButtonType.outline:
              case ButtonType.text:
              case ButtonType.textAndIcon:
                return null;
            }
          }(),
          border: Border.all(
            color: color ?? MColors.primaryColor,
            width: 1,
            style: () {
              switch (type) {
                case ButtonType.outline:
                  return BorderStyle.solid;
                case ButtonType.fill:
                case ButtonType.text:
                case ButtonType.textAndIcon:
                  return BorderStyle.none;
              }
            }(),
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            onTap: _canClick ? onClick : null,
            child: () {
              switch (type) {
                case ButtonType.outline:
                case ButtonType.text:
                case ButtonType.fill:
                  return Center(child: _finalChildWidget);
                case ButtonType.textAndIcon:
                  return _finalChildWidget;
              }
            }(),
          ),
        ),
      ),
    );
  }

  Widget get _finalChildWidget => Builder(
        builder: (context) => Padding(
          padding: padding ?? EdgeInsets.zero,
          child: AnimatedCrossFade(
            duration: UiUtils.duration,
            sizeCurve: UiUtils.curve,
            firstCurve: UiUtils.curve,
            secondCurve: UiUtils.curve,
            crossFadeState: isLoading
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: () {
              switch (type) {
                case ButtonType.outline:
                case ButtonType.text:
                case ButtonType.fill:
                  return _titleWidget;
                case ButtonType.textAndIcon:
                  return child ?? _titleWidget;
              }
            }(),
            secondChild: Center(
              child: AdaptiveLoadingWidget(
                color: switch (type) {
                  ButtonType.outline => MColors.primaryColor,
                  _ => MColors.secondaryColor,
                },
                stroke: loadingStroke ?? 3,
                size: loadingSize ?? 32,
              ),
            ),
          ),
        ),
      );

  Widget get _titleWidget => Builder(
        builder: (context) => AnimatedSwitcher(
          duration: UiUtils.duration,
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          child: AnimatedDefaultTextStyle(
            key: ValueKey(title),
            duration: UiUtils.duration,
            curve: UiUtils.curve,
            style: TextStyle(
              fontFamily: Fonts.yekan,
              color: isEnable
                  ? (textColor ??
                      switch (type) {
                        ButtonType.outline ||
                        ButtonType.text ||
                        ButtonType.textAndIcon =>
                          color ?? MColors.primaryColor,
                        ButtonType.fill => MColors.whiteColor,
                      })
                  : (disableTextColor ?? MColors.whiteColor.withOpacity(.5)),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: textSize,
                fontWeight: textWeight ?? Fonts.thin400,
                decoration: isUnderline ? TextDecoration.underline : null,
              ),
            ),
          ),
        ),
      );

  bool get _canClick => !isLoading && (isEnable || enableClickWhenDisable);
}
