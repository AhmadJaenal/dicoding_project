import 'dart:io';

import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/models/movie_table.dart';
import 'package:ditonton/data/models/serial_table.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() {
  late DatabaseHelper databaseHelper;

  setUpAll(() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;

    final path = await databaseFactory.getDatabasesPath();
    final dbPath = '$path/ditonton.db';
    if (await File(dbPath).exists()) {
      await File(dbPath).delete();
    }
  });

  setUp(() {
    databaseHelper = DatabaseHelper();
  });

  tearDown(() async {
    final db = await databaseHelper.database;
    await db!.delete('watchlist');
  });

  final tMovieTable = MovieTable(
    id: 1,
    title: 'Spiderman',
    posterPath: '/path.jpg',
    overview: 'Overview movie',
    isMovie: 1,
  );

  final tSerialTable = SerialTable(
    id: 2,
    title: 'Breaking Bad',
    posterPath: '/serial.jpg',
    overview: 'Overview serial',
  );

  group('Movie Watchlist', () {
    test('should insert movie to watchlist and be able to fetch it', () async {
      await databaseHelper.insertWatchlist(tMovieTable);
      final result =
          await databaseHelper.getWatchlistById(tMovieTable.id, true);

      expect(result, isNotNull);
      expect(result!['id'], tMovieTable.id);
      expect(result['title'], tMovieTable.title);
    });

    test('should return null when movie is not found', () async {
      final result = await databaseHelper.getWatchlistById(9999, true);
      expect(result, isNull);
    });

    test('should remove movie from watchlist', () async {
      await databaseHelper.insertWatchlist(tMovieTable);

      await databaseHelper.removeWatchlist(tMovieTable);
      final result =
          await databaseHelper.getWatchlistById(tMovieTable.id, true);

      expect(result, isNull);
    });

    test('should return list of watchlist movies', () async {
      await databaseHelper.insertWatchlist(tMovieTable);

      final result = await databaseHelper.getWatchlistMovies();

      expect(result, isA<List<Map<String, dynamic>>>());
      expect(result.isNotEmpty, true);
    });
  });

  group('Serial TV Watchlist', () {
    test('should insert serial to watchlist and be able to fetch it', () async {
      await databaseHelper.insertSerialWatchlist(tSerialTable);
      final result =
          await databaseHelper.getWatchlistById(tSerialTable.id, false);

      expect(result, isNotNull);
      expect(result!['id'], tSerialTable.id);
      expect(result['title'], tSerialTable.title);
    });

    test('should remove serial from watchlist', () async {
      await databaseHelper.insertSerialWatchlist(tSerialTable);

      await databaseHelper.removeSerialWatchlist(tSerialTable);
      final result =
          await databaseHelper.getWatchlistById(tSerialTable.id, false);

      expect(result, isNull);
    });
  });
}
