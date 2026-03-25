import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/pages/auth/auth_page.dart';
import '../features/pages/home/home_page.dart';
import '../features/pages/chat/chat_page.dart';

enum AppRoutes {
  home('/', 'home'),
  auth('/auth', 'auth'),
  chat('/chat', 'chat');

  final String path;
  final String name;

  const AppRoutes(this.path, this.name);
}

class AppRouter {
  final goRouter = GoRouter(
    initialLocation: AppRoutes.home.path,
    routes: [
      GoRoute(
        path: AppRoutes.home.path,
        name: AppRoutes.home.name,
        builder: (context, state) => const HomePage(),

        routes: [
          GoRoute(
            path: AppRoutes.chat.path,
            name: AppRoutes.chat.name,
            pageBuilder: (context, state) => _fade(const ChatPage(), state),
          ),

          GoRoute(
            path: AppRoutes.auth.path,
            name: AppRoutes.auth.name,
            pageBuilder: (context, state) {
              final extra = state.extra as AuthMode?;

              return _fade(
                AuthPage(initialMode: extra ?? AuthMode.register),
                state,
              );
            },
          ),
        ],
      ),
    ],
  );

  static CustomTransitionPage _fade(Widget child, GoRouterState state) {
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
