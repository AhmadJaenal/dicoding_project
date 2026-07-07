import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/serial_tv.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/repositories/serial_tv_repository.dart';

class GetSerialTVDetail {
  final SerialTVRepository repository;

  GetSerialTVDetail(this.repository);

  Future<Either<Failure, SerialTV>> execute(id) {
    return repository.getSerialTVDetail(id);
  }
}
