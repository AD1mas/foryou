import 'package:flutter/material.dart';

import '../../../core/app_style.dart';
import '../../widgets/custom_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("AI Helper")),
      body: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            Text("Welcome to the AI Helper!", style: AppTextStyles.heading),
            AppPaddingsHeight().medium(),
            Text("This is a simple AI helper app.", style: AppTextStyles.body),
            AppPaddingsHeight().medium(),
            Text("All for you!", style: AppTextStyles.subheading),
            AppPaddingsHeight().medium(),
            Text(
              "If you have any questions, feel free to ask!",
              style: AppTextStyles.body,
            ),
            AppPaddingsHeight().large(),
            CustomButton(
              text: "Go to Chat",
              onPressed: () => Navigator.pushNamed(context, '/chat'),
            ),
          ],
        ),
      ),
    );
  }
}
