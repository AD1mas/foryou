import 'dart:math';
import 'package:flutter/material.dart';

import '../../../core/app_style.dart';

class FancySwitch extends StatefulWidget {
  final bool value;
  final ValueChanged<bool> onChanged;

  const FancySwitch({super.key, required this.value, required this.onChanged});

  @override
  State<FancySwitch> createState() => _FancySwitchState();
}

class _FancySwitchState extends State<FancySwitch>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  late List<Offset> stars;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
      value: widget.value ? 1 : 0,
    );

    stars = List.generate(6, (i) {
      final rnd = Random(i);
      return Offset(rnd.nextDouble() * 50 + 10, rnd.nextDouble() * 20 + 5);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant FancySwitch oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (!_controller.isAnimating) {
      if (widget.value) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  void toggle() {
    final newValue = !widget.value;
    widget.onChanged(newValue);

    if (newValue) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggle,
      onHorizontalDragUpdate: (details) {
        _controller.value += details.primaryDelta! / 100;
      },
      onHorizontalDragEnd: (_) {
        final newValue = _controller.value > 0.5;
        widget.onChanged(newValue);

        if (newValue) {
          _controller.forward();
        } else {
          _controller.reverse();
        }
      },
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final t = Curves.easeInOut.transform(_controller.value);

          return Container(
            width: 90,
            height: 44,
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),

              /// Day-night gradient
              gradient: LinearGradient(
                colors: [
                  Color.lerp(
                    AppColors.dayBlueLight, // DAY
                    AppColors.nightBlueLight, // NIGHT
                    t,
                  )!,
                  Color.lerp(
                    AppColors.dayBlueDark,
                    AppColors.nightBlueDark,
                    t,
                  )!,
                ],
              ),

              /// Glow effect
              boxShadow: [
                BoxShadow(
                  color: Color.lerp(
                    AppColors.yellowColor.withValues(alpha: 0.4),
                    AppColors.purpleColor.withValues(alpha: 0.6),
                    t,
                  )!,
                  blurRadius: 15,
                  spreadRadius: 1,
                ),
              ],
            ),

            /// background elements + switcher
            child: Stack(
              children: [
                // Sky elements (clouds)
                ...List.generate(3, (i) {
                  return Positioned(
                    left: 10.0 + i * 20,
                    top: 8.0 + (i % 2) * 8,
                    child: Opacity(opacity: (1 - t), child: _cloud()),
                  );
                }),

                // Sky elements (stars)
                ...stars.map((pos) {
                  return Positioned(
                    left: pos.dx,
                    top: pos.dy,
                    child: Opacity(
                      opacity: t,
                      child: Container(
                        width: 2,
                        height: 2,
                        decoration: const BoxDecoration(
                          color: AppColors.whiteColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  );
                }),

                // Moon & Sun icons
                Positioned(
                  right: 10,
                  top: 8,
                  child: Opacity(
                    opacity: t,
                    child: const Icon(
                      Icons.nightlight_round,
                      size: 14,
                      color: AppColors.whiteColor,
                    ),
                  ),
                ),
                Positioned(
                  left: 10,
                  top: 8,
                  child: Opacity(
                    opacity: 1 - t,
                    child: const Icon(
                      Icons.wb_sunny,
                      size: 14,
                      color: AppColors.yellowColor,
                    ),
                  ),
                ),

                // Switcher
                Align(
                  alignment: Alignment.lerp(
                    Alignment.centerLeft,
                    Alignment.centerRight,
                    t,
                  )!,
                  child: Transform.scale(
                    scale: 1 + (0.1 * t),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Color.lerp(
                              AppColors.yellowColor,
                              AppColors.greyShade300,
                              t,
                            )!,
                            Color.lerp(
                              AppColors.orangeColor,
                              AppColors.greyShade600,
                              t,
                            )!,
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.darkGreyColor,
                            blurRadius: 6,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _cloud() {
    return Container(
      width: 16,
      height: 8,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
