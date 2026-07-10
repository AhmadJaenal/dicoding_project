import 'package:serialtv/domain/repositories/serial_tv_repository.dart';

class GetWatchListStatusSerialTV {
  final SerialTVRepository repository;

  GetWatchListStatusSerialTV(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
