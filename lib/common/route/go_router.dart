import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

import '../../technical/view/technical_interview_screen.dart';

class AppTransitions {
  static CustomTransitionPage<void> horizontalSlide({
    required LocalKey key,
    required Widget child,
    Offset begin = const Offset(2.0, 0.0),
  }) {
    return CustomTransitionPage<void>(
      key: key,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const end = Offset.zero;
        const curve = Curves.fastEaseInToSlowEaseOut;

        final tween =
        Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        final offsetAnimation = animation.drive(tween);
        return SlideTransition(position: offsetAnimation, child: child);
      },
    );
  }

  static CustomTransitionPage<void> fade({
    required LocalKey key,
    required Widget child,
    Duration duration = const Duration(milliseconds: 300),
  }) {
    return CustomTransitionPage<void>(
      key: key,
      child: child,
      transitionDuration: duration,
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    );
  }
}

final GoRouter router = GoRouter(
  initialLocation: '/mainpage',
  routes: [
    GoRoute(
      path: '/mainpage',
      name: TechnicalScreen.routeName,
      builder: (context, state) => const TechnicalScreen(),
    ),
  ],
);
