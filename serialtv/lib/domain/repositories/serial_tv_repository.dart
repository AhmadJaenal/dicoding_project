import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:serialtv/domain/entities/serial_tv.dart';

abstract class SerialTVRepository {
  Future<Either<Failure, List<SerialTV>>> getSerialTV();
  Future<Either<Failure, List<SerialTV>>> getSerialTVTopRated();
  Future<Either<Failure, List<SerialTV>>> getSerialTVPlayingNow();
  Future<Either<Failure, SerialTV>> getSerialTVDetail(int id);
  Future<Either<Failure, List<SerialTV>>> getSerialTVRecommendations();
  Future<Either<Failure, List<SerialTV>>> searchSerialTV(String query);
  Future<Either<Failure, String>> saveWatchlist(SerialTV movie);
  Future<Either<Failure, String>> removeWatchlist(SerialTV movie);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<SerialTV>>> getWatchlistSerialTV();
}
