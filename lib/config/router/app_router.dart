import 'package:gym_app/src/providers/providers.dart';
import 'package:gym_app/src/screens/screens.dart';
import 'package:go_router/go_router.dart';

UserProvider userProvider = UserProvider();
final appRouter = GoRouter(
  // initialLocation: '/login',
  refreshListenable: userProvider.status,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/reserve',
      builder: (context, state) => const ReservasScreen(),
    ),
    GoRoute(
      path: '/scan',
      builder: (context, state) => const ScanQRScreen(),
    ),
    GoRoute(
      path: '/horas',
      builder: (context, state) => const QrGenerateScreen(),
    ),
    GoRoute(
      path: '/test',
      builder: (context, state) => const TestScreen(),
    ),
  ],
  redirect: (context, state) {
    final isGoingTo = state.matchedLocation;
    final authStatus = userProvider.status.value;

    if (authStatus == AuthStatus.notAuthenticated) {
      // if (isGoingTo == '/login' || isGoingTo == '/register') return null;
      if (isGoingTo == '/login') return null;

      return '/login';
    }

    if (authStatus == AuthStatus.authenticated) {
      if (isGoingTo == '/login')
      // isGoingTo == '/register' ||
      // isGoingTo == '/splash')
      {
        return '/';
      }
    }
    return null;
  },
);
