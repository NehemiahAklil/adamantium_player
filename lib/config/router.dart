import 'package:adamantium_player/models/song_model.dart';
import 'package:adamantium_player/screens/home_screen.dart';
import 'package:adamantium_player/screens/library_screen.dart';
import 'package:adamantium_player/screens/settings_screen.dart';
import 'package:adamantium_player/screens/song_screen.dart';
import 'package:go_router/go_router.dart';

// final _rootNavigatorKey = GlobalKey<NavigatorState>();
// final _shellNavigatorKey = GlobalKey<NavigatorState>();

final GoRouter router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    path: '/song',
    builder: (context, state) {
      Song songArg = state.extra as Song;
      return SongScreen(song: songArg);
    },
  ),
  GoRoute(
    path: '/home',
    builder: (context, state) => const HomeScreen(),
  ),
  GoRoute(
    path: '/library',
    builder: (context, state) => const LibraryScreen(),
  ),
  GoRoute(
    path: '/settings',
    builder: (context, state) => const SettingsScreen(),
  ),
]);
