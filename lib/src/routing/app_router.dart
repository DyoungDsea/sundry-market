import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/access/access_page.dart';
import '../features/clock/clockin.dart';
import '../features/clock/clockout.dart';
import '../features/enrollment/enrollment.dart';
import '../features/get_started/get_started.dart';
import '../features/home/home.dart';
import '../features/home/offline/offline_clock.dart';

final goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const GetStarted(),
      routes: [
        GoRoute(
          path: 'accessForm',
          builder: (context, state) => const AccessForm(),
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            fullscreenDialog: true,
            child: const AccessForm(),
          ),
        ),
        GoRoute(
          path: 'enrollmentForm',
          builder: (context, state) => const EnrollmentForm(),
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            fullscreenDialog: true,
            child: const EnrollmentForm(),
          ),
        ),
        GoRoute(
          path: 'home',
          builder: (context, state) => const HomePage(),
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            fullscreenDialog: true,
            child: const HomePage(),
          ),
        ),
        GoRoute(
            path: 'clockin',
            builder: (context, state) => const ClockIn(),
            pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  fullscreenDialog: true,
                  child: const ClockIn(),
                ),
            routes: [
              GoRoute(
                path: 'enrollmentForm',
                builder: (context, state) => const EnrollmentForm(),
                pageBuilder: (context, state) => MaterialPage(
                  key: state.pageKey,
                  fullscreenDialog: true,
                  child: const EnrollmentForm(),
                ),
              )
            ]),
        GoRoute(
          path: 'clockout',
          builder: (context, state) => const ClockOut(),
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            fullscreenDialog: true,
            child: const ClockOut(),
          ),
        ),
        GoRoute(
          path: 'offline',
          builder: (context, state) => const ClockOffline(),
          pageBuilder: (context, state) => MaterialPage(
            key: state.pageKey,
            fullscreenDialog: true,
            child: const ClockOffline(),
          ),
        ),
      ],
    ),
  ],
);
