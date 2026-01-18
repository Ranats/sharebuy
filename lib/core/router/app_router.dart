import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/data/auth_repository.dart';
import '../../features/auth/presentation/auth_controller.dart';
import '../../features/auth/presentation/login_screen.dart';
import '../../features/group/presentation/group_hub_screen.dart';
import '../../features/list/presentation/list_index_screen.dart';
import '../../features/list/presentation/list_detail_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/settings/presentation/about_screen.dart';

part 'app_router.g.dart';

@riverpod
GoRouter appRouter(Ref ref) {
  final authState = ref.watch(authStateChangesProvider);

  return GoRouter(
    initialLocation: '/groups',
    routes: [
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/groups',
        builder: (context, state) => const GroupHubScreen(),
        routes: [
          GoRoute(
            path: ':groupId/lists',
            builder: (context, state) {
              final groupId = state.pathParameters['groupId']!;
              return ListIndexScreen(groupId: groupId);
            },
            routes: [
              GoRoute(
                path: ':listId',
                builder: (context, state) {
                  final groupId = state.pathParameters['groupId']!;
                  final listId = state.pathParameters['listId']!;
                  return ListDetailScreen(groupId: groupId, listId: listId);
                },
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
        routes: [
          GoRoute(
            path: 'about',
            builder: (context, state) => const AboutScreen(),
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      final isLoggedIn = authState.asData?.value != null;
      final isLoggingIn = state.matchedLocation == '/login';

      if (!isLoggedIn && !isLoggingIn) return '/login';
      if (isLoggedIn && isLoggingIn) return '/groups';
      return null;
    },
  );
}
