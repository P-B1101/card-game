import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/assets.dart';
import '../../utils/utils.dart';

class ToolbarState extends Equatable {
  final bool showBack;
  final Function()? callback;
  const ToolbarState({
    required this.showBack,
    required this.callback,
  });
  @override
  List<Object?> get props => [showBack, callback?.hashCode];
}

class ToolbarCubit extends Cubit<ToolbarState> {
  ToolbarCubit() : super(const ToolbarState(showBack: false, callback: null));

  void showBack(bool showBack) =>
      emit(ToolbarState(showBack: showBack, callback: state.callback));

  void setCallback(Function() callback) =>
      emit(ToolbarState(showBack: state.showBack, callback: callback));
}

class ToolbarWidget extends StatelessWidget {
  final Widget child;
  const ToolbarWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ToolbarCubit>(
      create: (context) => ToolbarCubit(),
      child: _ToolbarWidget(child: child),
    );
  }
}

class _ToolbarWidget extends StatelessWidget {
  final Widget child;
  const _ToolbarWidget({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: MColors.secondaryColor,
      child: Stack(
        children: [
          Positioned.fill(
            top: 42,
            child: child,
          ),
          Row(
            children: [
              SizedBox.square(
                dimension: 42,
                child: Material(
                  color: Colors.black.withOpacity(.1),
                  child: const InkWell(
                    onTap: Utils.exitApp,
                    child: Center(
                      child: Icon(
                        Icons.close,
                        size: 20,
                        color: MColors.whiteColor,
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: MouseRegion(
                  cursor: SystemMouseCursors.move,
                  child: GestureDetector(
                    onPanStart: (details) => appWindow.startDragging(),
                    child: Container(
                      height: 42,
                      width: double.infinity,
                      color: Colors.black.withOpacity(.1),
                    ),
                  ),
                ),
              ),
              BlocBuilder<ToolbarCubit, ToolbarState>(
                builder: (context, state) => AnimatedCrossFade(
                  duration: UiUtils.duration,
                  sizeCurve: UiUtils.curve,
                  firstCurve: UiUtils.curve,
                  secondCurve: UiUtils.curve,
                  crossFadeState: state.showBack
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  firstChild: SizedBox.square(
                    dimension: 42,
                    child: Material(
                      color: Colors.black.withOpacity(.1),
                      child: InkWell(
                        onTap: state.callback,
                        child: const Center(
                          child: RotatedBox(
                            quarterTurns: 2,
                            child: Icon(
                              Icons.arrow_back_rounded,
                              size: 20,
                              color: MColors.whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  secondChild: const SizedBox(height: 42),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
