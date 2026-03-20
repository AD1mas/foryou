import 'package:flutter/material.dart';

class AppColors {
  static const Color purpleColor = Color(0xFF610C9F);
  static const Color maroonColor = Color(0xFF940B92);
  static const Color redColor = Color(0xFFDA0C81);
  static const Color pinkColor = Color(0xFFE95793);
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
    color: Colors.white,
  );

  static const TextStyle subheading = TextStyle(
    fontSize: AppTextSizes.medium,
    fontWeight: FontWeight.w600,
    color: Colors.white,
  );

  static const TextStyle body = TextStyle(
    fontSize: AppTextSizes.small,
    color: Colors.white,
  );
}
