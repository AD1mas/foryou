import 'package:flutter/material.dart';
import 'package:foryou/core/app_style.dart';

class AnimatedSwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;
  final String leftText;
  final String rightText;

  const AnimatedSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    required this.leftText,
    required this.rightText,
  });

  @override
  State<AnimatedSwitch> createState() => _AnimatedSwitchState();
}

class _AnimatedSwitchState extends State<AnimatedSwitch>
    with SingleTickerProviderStateMixin {
  AnimationController? _controller;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
      value: widget.value ? 1 : 0,
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant AnimatedSwitch oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.value) {
      _controller!.forward();
    } else {
      _controller!.reverse();
    }
  }

  void toggle() {
    widget.onChanged(!widget.value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggle,
      child: _controller == null
          ? Container()
          : AnimatedBuilder(
              animation: _controller!,
              builder: (context, _) {
                final t = _controller!.value;

                return Container(
                  width: 240,
                  height: 55,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),

                    gradient: LinearGradient(
                      colors: [
                        Color.lerp(
                          AppColors.redColor,
                          AppMaterialColors.purpleSwatch,
                          t,
                        )!,
                        Color.lerp(
                          AppMaterialColors.pinkColor,
                          AppColors.maroonColor,
                          t,
                        )!,
                      ],
                    ),

                    boxShadow: [
                      BoxShadow(
                        color: Color.lerp(
                          AppColors.pinkColor.withValues(alpha: 0.3),
                          AppColors.purpleColor.withValues(alpha: 0.5),
                          t,
                        )!,
                        blurRadius: 15,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      /// Switcher
                      Align(
                        alignment: Alignment.lerp(
                          Alignment.centerLeft,
                          Alignment.centerRight,
                          Curves.easeOutBack.transform(t),
                        )!,
                        child: Container(
                          width: 115,
                          height: 47,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: AppColors.whiteColor.withValues(alpha: 0.15),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.darkGreyColor.withValues(
                                  alpha: 0.2,
                                ),
                                blurRadius: 10,
                                spreadRadius: 2,
                              ),
                            ],
                          ),
                        ),
                      ),

                      /// Texts
                      Row(
                        children: [
                          Expanded(
                            child: Center(
                              child: Transform.scale(
                                scale: 1 + (1 - t) * 0.1,
                                child: Opacity(
                                  opacity: 1 - t * 0.5,
                                  child: Text(
                                    widget.leftText,
                                    style: const TextStyle(
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Transform.scale(
                                scale: 1 + t * 0.1,
                                child: Opacity(
                                  opacity: 0.5 + t * 0.5,
                                  child: Text(
                                    widget.rightText,
                                    style: const TextStyle(
                                      color: AppColors.whiteColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
