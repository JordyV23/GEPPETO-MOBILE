import 'package:geppetto_mobile/presentation/screens/concepts/concepts_screen.dart';
import 'package:geppetto_mobile/presentation/screens/conversion/conversion_screen.dart';
import 'package:geppetto_mobile/presentation/screens/home/home_screen.dart';
import 'package:geppetto_mobile/presentation/screens/solver/solver_screen.dart';
import 'package:geppetto_mobile/presentation/screens/solvia/solvia_screen.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen()
    ),
    GoRoute(
      path: '/conversion',
      builder: (context, state) => const ConversionScreen()
    ),
    GoRoute(
      path: '/solver',
      builder: (context, state) => const SolverScreen(),
    ),
    GoRoute(
      path: '/solvia',
      builder: (context, state) => const SolvIAScreen(),
    ),
    GoRoute(
      path: '/concepts',
      builder: (context, state) => const ConceptsScreen(),
    )
  ]
);