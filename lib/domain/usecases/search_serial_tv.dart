import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:serialtv/domain/entities/serial_tv.dart';
import 'package:serialtv/domain/repositories/serial_tv_repository.dart';

class SerialTVSearch {
  final SerialTVRepository repository;

  SerialTVSearch(this.repository);

  Future<Either<Failure, List<SerialTV>>> execute(String query) {
    return repository.searchSerialTV(query);
  }
}
