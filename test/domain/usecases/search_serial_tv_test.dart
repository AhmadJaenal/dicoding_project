import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/search_serial_tv.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late SerialTVSearch usecase;
  late MockSerialTVRepository mockSerialTVRepository;

  setUp(() {
    mockSerialTVRepository = MockSerialTVRepository();
    usecase = SerialTVSearch(mockSerialTVRepository);
  });

  final tQuery = 'game of thrones';

  test('should get list of serial tv from the repository', () async {
    // arrange
    when(mockSerialTVRepository.searchSerialTV(tQuery))
        .thenAnswer((_) async => Right(tSerialTVList));
    // act
    final result = await usecase.execute(tQuery);
    // assert
    expect(result, Right(tSerialTVList));
  });
}
