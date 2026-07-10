import 'dart:ui';

import 'package:core/utils/constants.dart';
import 'package:core/utils/utils.dart';
import 'package:ditonton/firebase_options.dart';
import 'package:ditonton/presentation/bloc/get_detail_movie/get_detail_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/get_movie_recommendation/get_movie_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/get_movie_top_rated/get_movie_top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/get_playing_now_movie/get_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/get_popular_movie/get_popular_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/search/search_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist/watchlist_bloc.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:ditonton/presentation/pages/now_playing_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';

import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;
import 'package:serialtv/injection.dart' as diSerial;
import 'package:serialtv/presentation/bloc/get_serial_detail/get_detail_serial_bloc.dart';
import 'package:serialtv/presentation/bloc/get_serial_playing_now/get_serial_playing_now_bloc.dart';
import 'package:serialtv/presentation/bloc/get_serial_recommend/get_serial_recommendation_bloc.dart';
import 'package:serialtv/presentation/bloc/get_serial_top_rated/get_serial_top_rated_bloc.dart';
import 'package:serialtv/presentation/bloc/get_serial_tv_popular/get_serial_tv_popular_bloc.dart';
import 'package:serialtv/presentation/bloc/watchlist/watchlist_bloc.dart';
import 'package:serialtv/presentation/pages/serial_tv_detail_page.dart';
import 'package:serialtv/presentation/pages/serial_tv_page.dart';
import 'package:serialtv/presentation/pages/serial_tv_playing_now_page.dart';
import 'package:serialtv/presentation/pages/serial_tv_top_rated_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  di.initMovie();
  diSerial.initSerial();
  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(
      error,
      stack,
      fatal: true,
    );
    return true;
  };
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        //test
        BlocProvider(create: (_) => di.locator<GetDetailMovieBloc>()),
        BlocProvider(create: (_) => di.locator<GetMovieRecommendationBloc>()),
        BlocProvider(create: (_) => di.locator<GetMovieTopRatedBloc>()),
        BlocProvider(create: (_) => di.locator<GetSerialPlayingNowBloc>()),
        BlocProvider(create: (_) => di.locator<GetPopularMovieBloc>()),
        BlocProvider(create: (_) => di.locator<GetDetailSerialBloc>()),
        BlocProvider(create: (_) => di.locator<GetSerialPlayingNowBloc>()),
        BlocProvider(create: (_) => di.locator<GetMovieBloc>()),
        BlocProvider(create: (_) => di.locator<GetSerialTopRatedBloc>()),
        BlocProvider(create: (_) => di.locator<GetSerialTvPopularBloc>()),
        BlocProvider(create: (_) => di.locator<SearchBloc>()),
        BlocProvider(create: (_) => di.locator<WatchlistBloc>()),
        BlocProvider(create: (_) => di.locator<GetSerialPlayingNowBloc>()),
        BlocProvider(create: (_) => di.locator<GetSerialRecommendationBloc>()),
        BlocProvider(create: (_) => di.locator<WatchlistSerialTVBloc>()),
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
