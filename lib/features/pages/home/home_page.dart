import 'package:flutter/material.dart';
import 'package:foryou/navigation/app_router.dart';
import 'package:go_router/go_router.dart';

import '../../../core/app_style.dart';
import '../../widgets/buttons/home_custom_button.dart';
import '../../widgets/animation_widgets/wave_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AI Helper")),
      body: Stack(
        children: [
          WaveWidget(
            size: MediaQuery.sizeOf(context),
            yOffset: MediaQuery.sizeOf(context).height * 0.8,
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text("Welcome to the AI Helper!", style: AppTextStyles.heading),
                AppPaddingsHeight().medium(),
                Text(
                  "This is a simple AI helper app.",
                  style: AppTextStyles.body,
                ),
                AppPaddingsHeight().medium(),
                Text("All for you!", style: AppTextStyles.subheading),
                AppPaddingsHeight().medium(),
                Text(
                  "If you have any questions, feel free to ask!",
                  style: AppTextStyles.body,
                ),
                AppPaddingsHeight().large(),
                AnimatedGradientButton(
                  text: "Go to Auth",
                  onPressed: () => context.goNamed(AppRouter.auth.name),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
