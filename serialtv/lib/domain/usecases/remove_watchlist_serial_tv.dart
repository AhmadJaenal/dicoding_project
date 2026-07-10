import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:serialtv/domain/entities/serial_tv.dart';
import 'package:serialtv/domain/repositories/serial_tv_repository.dart';

class RemoveWatchlistSerialTV {
  final SerialTVRepository repository;

  RemoveWatchlistSerialTV(this.repository);

  Future<Either<Failure, String>> execute(SerialTV SerialTV) {
    return repository.removeWatchlist(SerialTV);
  }
}
