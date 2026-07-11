import 'package:ditonton/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tGenre = Genre(id: 1, name: 'Action');

  test('should create a valid Genre entity', () {
    expect(tGenre.id, 1);
    expect(tGenre.name, 'Action');
  });

  test('should return props containing id and name', () {
    expect(tGenre.props, [1, 'Action']);
  });
}
