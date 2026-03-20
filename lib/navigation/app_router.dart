import 'package:flutter/material.dart';
import '../features/pages/home/home_page.dart';
import '../features/pages/chat/chat_page.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _buildRoute(const HomePage());

      case '/chat':
        return _buildRoute(const ChatPage());

      default:
        return _buildRoute(const HomePage());
    }
  }

  static PageRouteBuilder _buildRoute(Widget page) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(opacity: animation, child: child);
      },
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
