import 'package:be_aware_android/generated_code/api_spec/api_spec.swagger.dart';
import 'package:be_aware_android/src/ui/pages/event_details/event_image_page.dart';
import 'package:be_aware_android/src/ui/pages/event_details/events_details_page.dart';
import 'package:be_aware_android/src/ui/pages/event_post/event_post_page.dart';
import 'package:be_aware_android/src/ui/pages/event_post/photo/event_take_photo_page.dart';
import 'package:be_aware_android/src/ui/pages/login/auto_login_page.dart';
import 'package:be_aware_android/src/ui/pages/login/login_page.dart';
import 'package:be_aware_android/src/ui/pages/login/register_page.dart';
import 'package:be_aware_android/src/ui/pages/map/map_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/auto-login',
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
    GoRoute(
      path: '/event/image',
      pageBuilder: (context, state) {
        return NoTransitionPage(
          key: state.pageKey,
          child: EventImagePage(
            imageUrl: state.extra as String,
          ),
        );
      },
    ),
    GoRoute(
      path: '/event/post',
      pageBuilder: (context, state) {
        return NoTransitionPage(
          key: state.pageKey,
          child: EventPostPage(),
        );
      },
    ),
    GoRoute(
      path: '/event/takephoto/:eventId',
      pageBuilder: (context, state) {
        return NoTransitionPage(
          key: state.pageKey,
          child: EventTakePhotoPage(
              eventId: int.parse(state.pathParameters['eventId'] as String)),
        );
      },
    ),
    GoRoute(
      path: '/login',
      pageBuilder: (context, state) {
        return NoTransitionPage(
          key: state.pageKey,
          child: const LoginPage(),
        );
      },
    ),
    GoRoute(
      path: '/auto-login',
      pageBuilder: (context, state) {
        return NoTransitionPage(
          key: state.pageKey,
          child: const AutoLoginPage(),
        );
      },
    ),
    GoRoute(
      path: '/register',
      pageBuilder: (context, state) {
        return NoTransitionPage(
          key: state.pageKey,
          child: const RegisterPage(),
        );
      },
    ),
  ],
);
