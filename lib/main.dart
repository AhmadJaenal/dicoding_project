import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/now_playing_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/serial_tv_detail_page.dart';
import 'package:ditonton/presentation/pages/serial_tv_page.dart';
import 'package:ditonton/presentation/pages/serial_tv_playing_now_page.dart';
import 'package:ditonton/presentation/pages/serial_tv_top_rated_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/now_playing_notifier.dart';
import 'package:ditonton/presentation/provider/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/search_serial_tv_notifier.dart';
import 'package:ditonton/presentation/provider/serial_tv_detail_notifier.dart';
import 'package:ditonton/presentation/provider/serial_tv_notifier.dart';
import 'package:ditonton/presentation/provider/serial_tv_playing_now_notifier.dart';
import 'package:ditonton/presentation/provider/serial_tv_top_rated_notifier.dart';
import 'package:ditonton/presentation/provider/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MovieListNotifier>(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider<MovieDetailNotifier>(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider<MovieSearchNotifier>(
          create: (_) => di.locator<MovieSearchNotifier>(),
        ),
        ChangeNotifierProvider<TopRatedMoviesNotifier>(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider<PopularMoviesNotifier>(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider<WatchlistMovieNotifier>(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        ChangeNotifierProvider<NowPlayingNotifier>(
          create: (_) => di.locator<NowPlayingNotifier>(),
        ),
        ChangeNotifierProvider<SerialTVNotifier>(
          create: (_) => di.locator<SerialTVNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<SerialTVDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<SerialSearchNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<SerialTVPlayingNowNotifier>(),
        ),
        ChangeNotifierProvider(
            create: (_) => di.locator<SerialTVTopRatedNotifier>()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: colorScheme,
          primaryColor: richBlack,
          scaffoldBackgroundColor: richBlack,
          textTheme: textTheme,
          drawerTheme: drawerTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case NowPlayingPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => NowPlayingPage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case SerialTVPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SerialTVPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            case SerialTVPlayingNowPage.ROUTE_NAME:
              return MaterialPageRoute(
                  builder: (_) => SerialTVPlayingNowPage());
            case SerialTVTopRatedPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => SerialTVTopRatedPage());
            case SerialTVDetail.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => SerialTVDetail(id: id),
                settings: settings,
              );

            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
