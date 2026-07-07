import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/serial_tv.dart';
import 'package:ditonton/domain/repositories/serial_tv_repository.dart';

class RemoveWatchlistSerialTV {
  final SerialTVRepository repository;

  RemoveWatchlistSerialTV(this.repository);

  Future<Either<Failure, String>> execute(SerialTV SerialTV) {
    return repository.removeWatchlist(SerialTV);
  }
}
