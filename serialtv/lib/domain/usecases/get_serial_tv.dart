import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:serialtv/domain/entities/serial_tv.dart';
import 'package:serialtv/domain/repositories/serial_tv_repository.dart';

class GetSerialTV {
  final SerialTVRepository repository;

  GetSerialTV(this.repository);

  Future<Either<Failure, List<SerialTV>>> execute() {
    return repository.getSerialTV();
  }
}
