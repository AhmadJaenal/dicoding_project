import 'package:flutter_test/flutter_test.dart';
import 'package:serialtv/data/models/serial_tv_model.dart';
import 'package:serialtv/domain/entities/serial_tv.dart';

void main() {
  final serialTVModel = SerialTVModel(
    adult: false,
    backdropPath: '/backdrop.jpg',
    genreIds: [1, 2, 3],
    id: 1,
    originCountry: ['US'],
    originalLanguage: 'en',
    originalName: 'Original Name',
    overview: 'This is an overview',
    popularity: 8.5,
    posterPath: '/poster.jpg',
    firstAirDate: DateTime(2020, 1, 1),
    softcore: false,
    name: 'Test Serial TV',
    voteAverage: 7.5,
    voteCount: 100,
  );

  final SerialTVEntity = SerialTV(
    adult: false,
    backdropPath: '/backdrop.jpg',
    genreIds: [1, 2, 3],
    id: 1,
    originCountry: ['US'],
    originalLanguage: 'en',
    originalName: 'Original Name',
    overview: 'This is an overview',
    popularity: 8.5,
    posterPath: '/poster.jpg',
    firstAirDate: DateTime(2020, 1, 1),
    softcore: false,
    name: 'Test Serial TV',
    voteAverage: 7.5,
    voteCount: 100,
    isMovie: 0,
  );

  test("should be a subclass of SerialTV entity", () async {
    final result = serialTVModel.toEntity();
    expect(result, SerialTVEntity);
  });
}
