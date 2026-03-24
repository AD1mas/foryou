import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/pages/auth/auth_page.dart';
import '../features/pages/home/home_page.dart';
import '../features/pages/chat/chat_page.dart';

enum AppRoutes { home, auth, chat }

class AppRouter {
  final goRouter = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        pageBuilder: (context, state) =>
            _fadeTransition(const HomePage(), state),
      ),

      GoRoute(
        path: AppRouter.auth.name,
        pageBuilder: (context, state) {
          final isRegistering =
              state.uri.queryParameters['register'] != 'false';
          return _fadeTransition(AuthPage(isRegistering: isRegistering), state);
        },
      ),

      GoRoute(
        path: AppRoutes.chat.name,
        pageBuilder: (context, state) =>
            _fadeTransition(const ChatPage(), state),
      ),
    ],
  );

  static CustomTransitionPage _fadeTransition(
    Widget child,
    GoRouterState state,
  ) {
    return CustomTransitionPage(
      key: state.pageKey,
      child: child,
      transitionDuration: const Duration(milliseconds: 400),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}
