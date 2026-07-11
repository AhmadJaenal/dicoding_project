import 'dart:convert';

import 'package:core/utils/exception.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:serialtv/data/datasources/serial_remote_data_source.dart';
import 'package:serialtv/data/models/serial_tv_model.dart';

import '../../helpers/test_helper.mocks.dart';
import '../../json_reader.dart';

void main() {
  const apiKey = 'api_key=2174d146bb9c0eab47529b2e77d6b526';
  const baseUrl = 'https://api.themoviedb.org/3';

  late SerialTVRemoteDataSourceImpl dataSource;
  late MockIOClient mockIOClient;

  setUp(() {
    mockIOClient = MockIOClient();
    dataSource = SerialTVRemoteDataSourceImpl(client: mockIOClient);
  });

  group('get Serial TV List', () {
    final tSerialTVList = SerialTVModel.fromJsonList(
      json.decode(readJson('dummy_data/serial_tv.json')),
    );

    test('should return list of SerialTVModel when response code is 200',
        () async {
      when(
        mockIOClient.get(
          Uri.parse('$baseUrl/tv/popular?$apiKey'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/serial_tv.json'),
          200,
        ),
      );

      final result = await dataSource.getSerialTV();

      expect(result, equals(tSerialTVList));
    });

    test('should throw ServerException when response code is not 200',
        () async {
      when(
        mockIOClient.get(
          Uri.parse('$baseUrl/tv/popular?$apiKey'),
        ),
      ).thenAnswer(
        (_) async => http.Response('Not Found', 404),
      );

      await expectLater(
        dataSource.getSerialTV(),
        throwsA(isA<ServerException>()),
      );
    });
  });

  group('get Top Rated Serial TV', () {
    final tSerialTVList = SerialTVModel.fromJsonList(
      json.decode(readJson('dummy_data/serial_tv.json')),
    );

    test('should return list of SerialTVModel when response code is 200',
        () async {
      when(
        mockIOClient.get(
          Uri.parse('$baseUrl/tv/top_rated?$apiKey'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/serial_tv.json'),
          200,
        ),
      );

      final result = await dataSource.getSerialTVTopRated();

      expect(result, equals(tSerialTVList));
    });

    test('should throw ServerException when response code is not 200',
        () async {
      when(
        mockIOClient.get(
          Uri.parse('$baseUrl/tv/top_rated?$apiKey'),
        ),
      ).thenAnswer(
        (_) async => http.Response('Not Found', 404),
      );

      await expectLater(
        dataSource.getSerialTVTopRated(),
        throwsA(isA<ServerException>()),
      );
    });
  });

  group('get On The Air Serial TV', () {
    final tSerialTVList = SerialTVModel.fromJsonList(
      json.decode(readJson('dummy_data/serial_tv.json')),
    );

    test('should return list of SerialTVModel when response code is 200',
        () async {
      when(
        mockIOClient.get(
          Uri.parse('$baseUrl/tv/on_the_air?$apiKey'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/serial_tv.json'),
          200,
        ),
      );

      final result = await dataSource.getSerialTVPlayingNow();

      expect(result, equals(tSerialTVList));
    });

    test('should throw ServerException when response code is not 200',
        () async {
      when(
        mockIOClient.get(
          Uri.parse('$baseUrl/tv/on_the_air?$apiKey'),
        ),
      ).thenAnswer(
        (_) async => http.Response('Not Found', 404),
      );

      await expectLater(
        dataSource.getSerialTVPlayingNow(),
        throwsA(isA<ServerException>()),
      );
    });
  });

  group('get Serial TV Detail', () {
    const tId = 1399;

    final tSerialTVDetail = SerialTVModel.fromJson(
      json.decode(readJson('dummy_data/serial_tv_detail.json')),
    );

    test('should return SerialTVModel when response code is 200', () async {
      when(
        mockIOClient.get(
          Uri.parse('$baseUrl/tv/$tId?$apiKey'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/serial_tv_detail.json'),
          200,
        ),
      );

      final result = await dataSource.getSerialTVDetail(tId);

      expect(result, equals(tSerialTVDetail));
    });

    test('should throw ServerException when response code is not 200',
        () async {
      when(
        mockIOClient.get(
          Uri.parse('$baseUrl/tv/$tId?$apiKey'),
        ),
      ).thenAnswer(
        (_) async => http.Response('Not Found', 404),
      );

      await expectLater(
        dataSource.getSerialTVDetail(tId),
        throwsA(isA<ServerException>()),
      );
    });
  });

  group('get Serial TV Recommendations', () {
    final tSerialTVList = SerialTVModel.fromJsonList(
      json.decode(readJson('dummy_data/serial_tv.json')),
    );

    test('should return list of SerialTVModel when response code is 200',
        () async {
      when(
        mockIOClient.get(
          Uri.parse('$baseUrl/tv/1399/recommendations?$apiKey'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/serial_tv.json'),
          200,
        ),
      );

      final result = await dataSource.getSerialTVRecommendations();

      expect(result, equals(tSerialTVList));
    });

    test('should throw ServerException when response code is not 200',
        () async {
      when(
        mockIOClient.get(
          Uri.parse('$baseUrl/tv/1399/recommendations?$apiKey'),
        ),
      ).thenAnswer(
        (_) async => http.Response('Not Found', 404),
      );

      await expectLater(
        dataSource.getSerialTVRecommendations(),
        throwsA(isA<ServerException>()),
      );
    });
  });

  group('search Serial TV', () {
    const tQuery = 'Spiderman';

    final tSearchResult = SerialTVModel.fromJsonList(
      json.decode(readJson('dummy_data/serial_tv.json')),
    );

    test('should return list of SerialTVModel when response code is 200',
        () async {
      when(
        mockIOClient.get(
          Uri.parse(
            '$baseUrl/search/tv?query=$tQuery&include_adult=false&language=en-US&$apiKey',
          ),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          readJson('dummy_data/serial_tv.json'),
          200,
        ),
      );

      final result = await dataSource.searchSerialTV(tQuery);

      expect(result, equals(tSearchResult));
    });

    test('should throw ServerException when response code is not 200',
        () async {
      when(
        mockIOClient.get(
          Uri.parse(
            '$baseUrl/search/tv?query=$tQuery&include_adult=false&language=en-US&$apiKey',
          ),
        ),
      ).thenAnswer(
        (_) async => http.Response('Not Found', 404),
      );

      await expectLater(
        dataSource.searchSerialTV(tQuery),
        throwsA(isA<ServerException>()),
      );
    });
  });
}
