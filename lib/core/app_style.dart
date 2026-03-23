import 'package:flutter/material.dart';

class AppColors {
  static const Color purpleColor = Color(0xFF610C9F);
  static const Color maroonColor = Color(0xFF940B92);
  static const Color redColor = Color(0xFFDA0C81);
  static const Color pinkColor = Color(0xFFE95793);

  static const Color transparentColor = Colors.transparent;
  static const Color greyOpacityColor = Color(0x52373737);

  static const Color whiteColor = Colors.white;
  static const Color blackColor = Colors.black;
  static const Color grayColor = Colors.grey;

  static const Color darkGreyColor = Color(0xFF111111);
  static const Color lightGreyColor = Color(0xFFE1E1E1);

  static const Color blueColor = Colors.blue;

  static const Color yellowColor = Colors.yellow;
  static const Color orangeColor = Colors.orange;

  static const Color greyShade300 = Color(0xFFE0E0E0);
  static const Color greyShade600 = Color(0xFF9E9E9E);

  static const Color dayBlueLight = Color(0xFF4FC3F7);
  static const Color dayBlueDark = Color(0xFF81D4FA);
  static const Color nightBlueLight = Color(0xFF0D1B2A);
  static const Color nightBlueDark = Colors.black;
}

class AppGradients {
  static const LinearGradient purpleGradient = LinearGradient(
    colors: [AppColors.purpleColor, AppColors.maroonColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient pinkGradient = LinearGradient(
    colors: [AppColors.pinkColor, AppColors.redColor],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

class AppMaterialColors {
  static const MaterialColor purpleSwatch =
      MaterialColor(0xFF610C9F, <int, Color>{
        50: Color(0xFFEDE7F6),
        100: Color(0xFFD1C4E9),
        200: Color(0xFFB39DDB),
        300: Color(0xFF9575CD),
        400: Color(0xFF7E57C2),
        500: Color(0xFF610C9F),
        600: Color(0xFF5E35B1),
        700: Color(0xFF512DA8),
        800: Color(0xFF4527A0),
        900: Color(0xFF311B92),
      });

  static const MaterialColor pinkColor = MaterialColor(0xFFE95793, <int, Color>{
    50: Color(0xFFFCE4EC),
    100: Color(0xFFF8BBD0),
    200: Color(0xFFF48FB1),
    300: Color(0xFFF06292),
    400: Color(0xFFEC407A),
    500: Color(0xFFE95793),
    600: Color(0xFFD81B60),
    700: Color(0xFFC2185B),
    800: Color(0xFFAD1457),
    900: Color(0xFF880E4F),
  });
}

class AppTextSizes {
  static const double small = 18.0;
  static const double medium = 24.0;
  static const double large = 30.0;
}

class AppPaddingsHeight {
  SizedBox small() => const SizedBox(height: 8.0);
  SizedBox medium() => const SizedBox(height: 16.0);
  SizedBox large() => const SizedBox(height: 24.0);
}

class AppPaddingsWidth {
  SizedBox small() => const SizedBox(width: 8.0);
  SizedBox medium() => const SizedBox(width: 16.0);
  SizedBox large() => const SizedBox(width: 24.0);
}

class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontSize: AppTextSizes.large,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle subheading = TextStyle(
    fontSize: AppTextSizes.medium,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle body = TextStyle(fontSize: AppTextSizes.small);
}
