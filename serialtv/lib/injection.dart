import 'package:core/helper/database_helper.dart';
import 'package:core/utils/ssl_pinning_http_client.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:serialtv/serial_tv.dart';

final locator = GetIt.instance;

void initSerial() async {
  // bloc
  locator.registerFactory(() => GetSerialPlayingNowBloc(locator()));
  locator.registerFactory(() => GetDetailSerialBloc(locator(), locator()));
  locator.registerFactory(() => GetSerialTopRatedBloc(locator()));
  locator.registerFactory(() => GetSerialTvPopularBloc(locator()));
  locator.registerFactory(() => GetSerialRecommendationBloc(locator()));
  locator.registerFactory(() => WatchlistSerialTVBloc(locator(), locator()));

  // use case
  locator.registerFactory(() => GetSerialTV(locator()));
  locator.registerFactory(() => GetSerialTVDetail(locator()));
  locator.registerFactory(() => GetSerialTVPlayingNow(locator()));
  locator.registerFactory(() => GetSerialTVTopRated(locator()));
  locator.registerFactory(() => RemoveWatchlistSerialTV(locator()));
  locator.registerFactory(() => SaveWatchlistSerial(locator()));
  locator.registerFactory(() => GetWatchListStatusSerialTV(locator()));
  locator.registerFactory(() => GetSerialTVRecommendations(locator()));

  // repository
  locator.registerLazySingleton<SerialTVRepository>(
    () => SerialTVRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<SerialRemoteDataSource>(
    () => SerialTVRemoteDataSourceImpl(client: locator()),
  );
  locator.registerLazySingleton<SerialLocalDataSource>(
    () => SerialLocalDataSourceImpl(databaseHelper: locator()),
  );

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());

  // http client
  final client = await SSLPinningHttpClient.getClient();
  locator.registerLazySingleton<IOClient>(() => client);
}
