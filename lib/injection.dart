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
import 'package:ditonton/presentation/bloc/get_detail_movie/get_detail_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/get_movie_recommendation/get_movie_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/get_movie_top_rated/get_movie_top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/get_playing_now_movie/get_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/get_popular_movie/get_popular_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/get_serial_detail/get_detail_serial_bloc.dart';
import 'package:ditonton/presentation/bloc/get_serial_playing_now/get_serial_playing_now_bloc.dart';
import 'package:ditonton/presentation/bloc/get_serial_recommend/get_serial_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/get_serial_top_rated/get_serial_top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/get_serial_tv_popular/get_serial_tv_popular_bloc.dart';
import 'package:ditonton/presentation/bloc/search/search_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist/watchlist_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init() {
  // bloc
  locator.registerFactory(() => GetDetailMovieBloc(locator(), locator()));
  locator.registerFactory(() => GetMovieTopRatedBloc(locator()));
  locator.registerFactory(() => GetMovieRecommendationBloc(locator()));
  locator.registerFactory(() => GetSerialPlayingNowBloc(locator()));
  locator.registerFactory(() => GetPopularMovieBloc(locator()));
  locator.registerFactory(() => GetDetailSerialBloc(locator(), locator()));
  locator.registerFactory(() => GetMovieBloc(locator()));
  locator.registerFactory(() => GetSerialTopRatedBloc(locator()));
  locator.registerFactory(() => GetSerialTvPopularBloc(locator()));
  locator.registerFactory(() => GetSerialRecommendationBloc(locator()));
  locator.registerFactory(() => SearchBloc(locator(), locator()));
  locator.registerFactory(() =>
      WatchlistBloc(locator(), locator(), locator(), locator(), locator()));

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
