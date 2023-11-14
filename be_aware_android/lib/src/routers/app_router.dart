import 'package:be_aware_android/generated_code/api_spec/api_spec.swagger.dart';
import 'package:be_aware_android/src/ui/pages/event_details/events_details_page.dart';
import 'package:be_aware_android/src/ui/pages/map/map_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/map',
  routes: [
    GoRoute(
      path: '/map',
      pageBuilder: (context, state) {
        return NoTransitionPage(
          key: state.pageKey,
          child: const MapPage(),
        );
      },
    ),
    GoRoute(
      path: '/event',
      pageBuilder: (context, state) {
        return NoTransitionPage(
          key: state.pageKey,
          child: EventDetailsPage(
            event: state.extra as EventDto,
          ),
        );
      },
    ),
  ],
);
