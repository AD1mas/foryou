import 'package:flutter/material.dart';

import '../../../core/app_style.dart';
import '../../widgets/home_custom_button.dart';
import '../../widgets/wave_widget.dart';

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
            yOffset: 200,
            color: AppColors.maroonColor,
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
                  text: "Go to Chat",
                  onPressed: () => Navigator.pushNamed(context, '/chat'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
