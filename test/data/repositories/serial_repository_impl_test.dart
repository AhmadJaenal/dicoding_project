import 'dart:io';

import 'package:core/utils/exception.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:serialtv/serial_tv.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SerialTVRepositoryImpl repository;
  late MockSerialRemoteDataSource mockRemoteDataSource;
  late MockSerialLocalDataSource mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockSerialRemoteDataSource();
    mockLocalDataSource = MockSerialLocalDataSource();
    repository = SerialTVRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
    );
  });

  group('Get Serial TV (Now Playing / All)', () {
    test(
        'should return remote data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getSerialTV())
          .thenAnswer((_) async => tSerialModelList);
      // act
      final result = await repository.getSerialTV();
      // assert
      verify(mockRemoteDataSource.getSerialTV());
      final resultList = result.getOrElse(() => []);
      expect(resultList, tSerialTVList);
    });

    test(
        'should return server failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getSerialTV()).thenThrow(ServerException());
      // act
      final result = await repository.getSerialTV();
      // assert
      verify(mockRemoteDataSource.getSerialTV());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getSerialTV())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getSerialTV();
      // assert
      verify(mockRemoteDataSource.getSerialTV());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Serial TV Playing Now', () {
    test('should return serial tv list when call to data source is success',
        () async {
      // arrange
      when(mockRemoteDataSource.getSerialTVPlayingNow())
          .thenAnswer((_) async => tSerialModelList);
      // act
      final result = await repository.getSerialTVPlayingNow();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tSerialTVList);
    });

    test(
        'should return server failure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getSerialTVPlayingNow())
          .thenThrow(ServerException());
      // act
      final result = await repository.getSerialTVPlayingNow();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return connection failure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getSerialTVPlayingNow())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getSerialTVPlayingNow();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Serial TV Top Rated', () {
    test('should return serial tv list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getSerialTVTopRated())
          .thenAnswer((_) async => tSerialModelList);
      // act
      final result = await repository.getSerialTVTopRated();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tSerialTVList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getSerialTVTopRated())
          .thenThrow(ServerException());
      // act
      final result = await repository.getSerialTVTopRated();
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getSerialTVTopRated())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getSerialTVTopRated();
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('Get Serial TV Detail', () {
    final tId = 1;

    test(
        'should return Serial TV data when the call to remote data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getSerialTVDetail(tId))
          .thenAnswer((_) async => tSerialTVModel);
      // act
      final result = await repository.getSerialTVDetail(tId);
      // assert
      verify(mockRemoteDataSource.getSerialTVDetail(tId));
      expect(result, equals(Right(tSerialTV)));
    });

    test(
        'should return Server Failure when the call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getSerialTVDetail(tId))
          .thenThrow(ServerException());
      // act
      final result = await repository.getSerialTVDetail(tId);
      // assert
      verify(mockRemoteDataSource.getSerialTVDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getSerialTVDetail(tId))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getSerialTVDetail(tId);
      // assert
      verify(mockRemoteDataSource.getSerialTVDetail(tId));
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Get Serial TV Recommendations', () {
    test('should return data (serial tv list) when the call is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.getSerialTVRecommendations())
          .thenAnswer((_) async => tSerialModelList);
      // act
      final result = await repository.getSerialTVRecommendations();
      // assert
      verify(mockRemoteDataSource.getSerialTVRecommendations());
      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tSerialTVList));
    });

    test(
        'should return server failure when call to remote data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.getSerialTVRecommendations())
          .thenThrow(ServerException());
      // act
      final result = await repository.getSerialTVRecommendations();
      // assert
      verify(mockRemoteDataSource.getSerialTVRecommendations());
      expect(result, equals(Left(ServerFailure(''))));
    });

    test(
        'should return connection failure when the device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.getSerialTVRecommendations())
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.getSerialTVRecommendations();
      // assert
      verify(mockRemoteDataSource.getSerialTVRecommendations());
      expect(result,
          equals(Left(ConnectionFailure('Failed to connect to the network'))));
    });
  });

  group('Search Serial TV', () {
    final tQuery = 'game of thrones';

    test('should return serial tv list when call to data source is successful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchSerialTV(tQuery))
          .thenAnswer((_) async => tSerialModelList);
      // act
      final result = await repository.searchSerialTV(tQuery);
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, tSerialTVList);
    });

    test('should return ServerFailure when call to data source is unsuccessful',
        () async {
      // arrange
      when(mockRemoteDataSource.searchSerialTV(tQuery))
          .thenThrow(ServerException());
      // act
      final result = await repository.searchSerialTV(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });

    test(
        'should return ConnectionFailure when device is not connected to the internet',
        () async {
      // arrange
      when(mockRemoteDataSource.searchSerialTV(tQuery))
          .thenThrow(SocketException('Failed to connect to the network'));
      // act
      final result = await repository.searchSerialTV(tQuery);
      // assert
      expect(
          result, Left(ConnectionFailure('Failed to connect to the network')));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testSerialTable))
          .thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(tSerialTVWatchlist);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testSerialTable))
          .thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(tSerialTVWatchlist);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testSerialTable))
          .thenAnswer((_) async => 'Removed from watchlist');
      // act
      final result = await repository.removeWatchlist(tSerialTVWatchlist);
      // assert
      expect(result, Right('Removed from watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testSerialTable))
          .thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(tSerialTVWatchlist);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return true when data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.getSerialTVById(tId))
          .thenAnswer((_) async => testSerialTable);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, true);
    });

    test('should return false when data is not found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.getSerialTVById(tId))
          .thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist serial tv', () {
    test('should return list of Serial TV', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistSerialTV())
          .thenAnswer((_) async => [testSerialTable]);
      // act
      final result = await repository.getWatchlistSerialTV();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [tSerialTVWatchlist]);
    });
  });
}
