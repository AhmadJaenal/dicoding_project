import 'package:ditonton/common/exception.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/serial_table.dart';

abstract class SerialLocalDataSource {
  Future<String> insertWatchlist(SerialTable movie);
  Future<String> removeWatchlist(SerialTable movie);
  Future<SerialTable?> getSerialTVById(int id);
  Future<List<SerialTable>> getWatchlistSerialTV();
}

class SerialLocalDataSourceImpl implements SerialLocalDataSource {
  final DatabaseHelper databaseHelper;

  SerialLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> insertWatchlist(SerialTable movie) async {
    try {
      await databaseHelper.insertSerialWatchlist(movie);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(SerialTable movie) async {
    try {
      await databaseHelper.removeSerialWatchlist(movie);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<SerialTable?> getSerialTVById(int id) async {
    final result = await databaseHelper.getSerialTVById(id);
    if (result != null) {
      return SerialTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<SerialTable>> getWatchlistSerialTV() async {
    final result = await databaseHelper.getWatchlistSerialTV();
    return result.map((data) => SerialTable.fromMap(data)).toList();
  }
}
