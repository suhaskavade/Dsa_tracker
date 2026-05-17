import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:dsa_tracker/presentation/features/main_layout.dart';
import 'package:dsa_tracker/presentation/features/dashboard/dashboard_page.dart';
import 'package:dsa_tracker/presentation/features/roadmap/roadmap_page.dart';
import 'package:dsa_tracker/presentation/features/questions/questions_page.dart';
import 'package:dsa_tracker/presentation/features/solver/question_detail_page.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/dashboard',
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return MainLayout(child: child);
      },
      routes: [
        GoRoute(
          path: '/dashboard',
          builder: (context, state) => const DashboardPage(),
        ),
        GoRoute(
          path: '/roadmap',
          builder: (context, state) => const RoadmapPage(),
        ),
        GoRoute(
          path: '/questions',
          builder: (context, state) => const QuestionsPage(),
          routes: [
            GoRoute(
              path: ':id',
              builder: (context, state) {
                final id = int.tryParse(state.pathParameters['id'] ?? '0') ?? 0;
                return QuestionDetailPage(leetcodeId: id);
              },
            ),
          ],
        ),
      ],
    ),
  ],
);
