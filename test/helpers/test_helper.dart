import 'package:core/helper/database_helper.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/search_serial_tv.dart';
import 'package:ditonton/presentation/bloc/get_detail_movie/get_detail_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/get_movie_recommendation/get_movie_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/get_movie_top_rated/get_movie_top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/get_popular_movie/get_popular_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/search/search_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist/watchlist_bloc.dart';
import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';
import 'package:serialtv/data/datasources/serial_local_data_source.dart';
import 'package:serialtv/data/datasources/serial_remote_data_source.dart';
import 'package:serialtv/data/repositories/serial_tv_repository_impl.dart';
import 'package:serialtv/domain/repositories/serial_tv_repository.dart';
import 'package:serialtv/domain/usecases/get_serial_tv.dart';
import 'package:serialtv/domain/usecases/get_serial_tv_playing_now.dart';
import 'package:serialtv/domain/usecases/get_serial_tv_recommedations.dart';
import 'package:serialtv/domain/usecases/get_serial_tv_top_rated.dart';
import 'package:serialtv/domain/usecases/get_watchlist_serial_tv.dart';
import 'package:serialtv/domain/usecases/remove_watchlist_serial_tv.dart';
import 'package:serialtv/domain/usecases/save_watchlist_serial_tv.dart';

@GenerateMocks([
  // repository
  MovieRepository,
  SerialTVRepository,

  // datasource
  MovieRemoteDataSource,
  MovieLocalDataSource,
  SerialLocalDataSource,
  SerialRemoteDataSource,

  // use case
  DatabaseHelper,
  GetMovieDetail,
  GetWatchListStatus,
  GetMovieRecommendations,
  GetTopRatedMovies,
  GetNowPlayingMovies,
  GetPopularMovies,
  GetSerialTV,
  GetSerialTVPlayingNow,
  GetSerialTVRecommendations,
  GetSerialTVTopRated,
  GetWatchlistSerialTV,
  RemoveWatchlistSerialTV,
  SaveWatchlistSerial,
  SearchMovies,
  SerialTVSearch,
  SaveWatchlist,
  RemoveWatchlist,
  GetWatchlistMovies,
  MovieRepositoryImpl,
  SerialTVRepositoryImpl,

  // bloc
  GetMovieRecommendationBloc,
  GetDetailMovieBloc,
  GetPopularMovieBloc,
  WatchlistBloc,
  SearchBloc,
  GetMovieTopRatedBloc,
], customMocks: [
  MockSpec<IOClient>(as: #MockIOClient),
])
void main() {}
