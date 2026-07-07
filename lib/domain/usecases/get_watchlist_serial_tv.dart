import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/serial_tv.dart';
import 'package:ditonton/domain/repositories/serial_tv_repository.dart';

class GetWatchlistSerialTV {
  final SerialTVRepository _repository;

  GetWatchlistSerialTV(this._repository);

  Future<Either<Failure, List<SerialTV>>> execute() {
    return _repository.getWatchlistSerialTV();
  }
}
