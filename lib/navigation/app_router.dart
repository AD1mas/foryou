import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:foryou/services/supabase/auth_service.dart';
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
            redirect: (context, state) {
              final isLoggedIn = AuthService().session != null;
              final path = state.uri.path;

              if (!isLoggedIn && path == AppRoutes.chat.path) {
                return AppRoutes.auth.path;
              }

              if (isLoggedIn && path == AppRoutes.auth.path) {
                return AppRoutes.chat.path;
              }

              return null;
            },
          ),

          GoRoute(
            path: AppRoutes.auth.path,
            name: AppRoutes.auth.name,
            redirect: (context, state) {
              final isLoggedIn = AuthService().session != null;
              final path = state.uri.path;

              if (!isLoggedIn && path == AppRoutes.chat.path) {
                return AppRoutes.auth.path;
              }

              if (isLoggedIn && path == AppRoutes.auth.path) {
                return AppRoutes.chat.path;
              }

              return null;
            },
            pageBuilder: (context, state) {
              final extra = state.extra as AuthMode?;
              if (kDebugMode) {
                print(extra);
              }

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
