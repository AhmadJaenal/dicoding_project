import 'package:ditonton/data/models/genre_model.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  var tGenreModel = GenreModel(
    id: 28,
    name: 'Action',
  );

  var tGenre = Genre(
    id: 28,
    name: 'Action',
  );

  group('GenreModel', () {
    test('should be a subclass of Equatable', () {
      expect(tGenreModel, isA<GenreModel>());
    });

    test('should return a valid model from JSON', () {
      final jsonMap = {
        'id': 28,
        'name': 'Action',
      };

      final result = GenreModel.fromJson(jsonMap);

      expect(result, tGenreModel);
    });

    test('should return a JSON map containing proper data', () {
      final result = tGenreModel.toJson();

      final expectedJson = {
        'id': 28,
        'name': 'Action',
      };

      expect(result, expectedJson);
    });

    test('should convert to entity', () {
      final result = tGenreModel.toEntity();

      expect(result, tGenre);
    });

    test('should support value equality', () {
      var anotherGenreModel = GenreModel(
        id: 28,
        name: 'Action',
      );

      expect(tGenreModel, equals(anotherGenreModel));
    });

    test('props should contain id and name', () {
      expect(
        tGenreModel.props,
        [28, 'Action'],
      );
    });
  });
}
