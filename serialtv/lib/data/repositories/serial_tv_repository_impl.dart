import 'dart:io';

import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:serialtv/data/datasources/serial_local_data_source.dart';
import 'package:serialtv/data/datasources/serial_remote_data_source.dart';
import 'package:serialtv/data/models/serial_table.dart';
import 'package:serialtv/domain/entities/serial_tv.dart';
import 'package:serialtv/domain/repositories/serial_tv_repository.dart';

class SerialTVRepositoryImpl implements SerialTVRepository {
  final SerialTVRemoteDataSource remoteDataSource;
  final SerialLocalDataSource localDataSource;

  SerialTVRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<SerialTV>>> getSerialTV() async {
    try {
      final result = await remoteDataSource.getSerialTV();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  Future<Either<Failure, List<SerialTV>>> getSerialTVTopRated() async {
    try {
      final result = await remoteDataSource.getSerialTVTopRated();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  Future<Either<Failure, List<SerialTV>>> getSerialTVPlayingNow() async {
    try {
      final result = await remoteDataSource.getSerialTVPlayingNow();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, SerialTV>> getSerialTVDetail(int id) async {
    try {
      final result = await remoteDataSource.getSerialTVDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<SerialTV>>> getSerialTVRecommendations() async {
    try {
      final result = await remoteDataSource.getSerialTVRecommendations();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<SerialTV>>> searchSerialTV(String query) async {
    try {
      final result = await remoteDataSource.searchSerialTV(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, String>> saveWatchlist(SerialTV SerialTV) async {
    try {
      final result = await localDataSource.insertWatchlist(
        SerialTable.fromEntity(SerialTV),
      );
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(SerialTV SerialTV) async {
    try {
      final result = await localDataSource.removeWatchlist(
        SerialTable.fromEntity(SerialTV),
      );
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await localDataSource.getSerialTVById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, List<SerialTV>>> getWatchlistSerialTV() async {
    final result = await localDataSource.getWatchlistSerialTV();
    return Right(result.map((data) => data.toEntity()).toList());
  }
}
