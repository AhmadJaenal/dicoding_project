import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/datasources/serial_local_data_source.dart';
import 'package:ditonton/data/datasources/serial_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/data/repositories/serial_tv_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/serial_tv_repository.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_serial_tv.dart';
import 'package:ditonton/domain/usecases/get_serial_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_serial_tv_playing_now.dart';
import 'package:ditonton/domain/usecases/get_serial_tv_recommedations.dart';
import 'package:ditonton/domain/usecases/get_serial_tv_top_rated.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_serial_tv.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_serial_tv.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_serial_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist_serial_tv.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/search_serial_tv.dart';
import 'package:ditonton/presentation/provider/movie_detail_notifier.dart';
import 'package:ditonton/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:ditonton/presentation/provider/popular_movies_notifier.dart';
import 'package:ditonton/presentation/provider/search_serial_tv_notifier.dart';
import 'package:ditonton/presentation/provider/serial_tv_detail_notifier.dart';
import 'package:ditonton/presentation/provider/serial_tv_notifier.dart';
import 'package:ditonton/presentation/provider/serial_tv_playing_now_notifier.dart';
import 'package:ditonton/presentation/provider/serial_tv_top_rated_notifier.dart';
import 'package:ditonton/presentation/provider/top_rated_movies_notifier.dart';
import 'package:ditonton/presentation/provider/watchlist_movie_notifier.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => SerialTVNotifier(
      getSerialTV: locator(),
    ),
  );
  locator.registerFactory(
    () => SerialTVDetailNotifier(
      getSerialTVDetail: locator(),
      getSerialeRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => SerialSearchNotifier(
      searchSerial: locator(),
    ),
  );
  locator.registerFactory(
    () => SerialTVTopRatedNotifier(
      getSerialTVTopRated: locator(),
    ),
  );
  locator.registerFactory(
    () => SerialTVPlayingNowNotifier(
      getSerialTVPlayingNow: locator(),
    ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => GetSerialTV(locator()));
  locator.registerLazySingleton(() => GetSerialTVDetail(locator()));
  locator.registerLazySingleton(() => GetSerialTVRecommendations(locator()));
  locator.registerLazySingleton(() => SerialTVSearch(locator()));
  locator.registerLazySingleton(() => GetWatchListStatusSerialTV(locator()));
  locator.registerLazySingleton(() => SaveWatchlistSerial(locator()));
  locator.registerLazySingleton(() => RemoveWatchlistSerialTV(locator()));
  locator.registerLazySingleton(() => GetWatchlistSerialTV(locator()));
  locator.registerLazySingleton(() => GetSerialTVTopRated(locator()));
  locator.registerLazySingleton(() => GetSerialTVPlayingNow(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<SerialTVRepository>(
    () => SerialTVRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  locator.registerLazySingleton<SerialTVRemoteDataSource>(
    () => SerialTVRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton<SerialLocalDataSource>(
    () => SerialLocalDataSourceImpl(
      databaseHelper: locator(),
    ),
  );

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
