import 'package:ditonton/data/models/serial_table.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tSerialTV = SerialTable(
    id: 1,
    title: 'Test Serial TV',
    posterPath: '/poster.jpg',
    overview: 'This is an overview',
  );

  final tSerialTVMap = {
    'id': 1,
    'title': 'Test Serial TV',
    'posterPath': '/poster.jpg',
    'overview': 'This is an overview',
    'isMovie': 0,
  };

  test('should be a subclass of SerialTable entity', () async {
    final result = tSerialTV.toJson();
    expect(result, tSerialTVMap);
  });

  final tSerialTVEntity = tSerialTV.toEntity();
  test('should be a subclass of SerialTV entity', () async {
    final result = tSerialTV.toEntity();
    expect(result, tSerialTVEntity);
  });

  final tSerialTVFromMap = SerialTable.fromMap(tSerialTVMap);
  test('should be a subclass of SerialTable entity from map', () async {
    final result = SerialTable.fromMap(tSerialTVMap);
    expect(result, tSerialTVFromMap);
  });
}
