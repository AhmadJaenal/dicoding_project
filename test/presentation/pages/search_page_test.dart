import 'package:ditonton/presentation/bloc/search/search_bloc.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockSearchBloc mockSearchBloc;

  setUpAll(() {
    provideDummy<SearchState>(SearchBlocInitial());
  });

  setUp(() {
    mockSearchBloc = MockSearchBloc();
    when(mockSearchBloc.state).thenReturn(SearchBlocInitial());
    when(mockSearchBloc.stream).thenAnswer(
      (_) => Stream.value(SearchBlocInitial()),
    );
  });

  testWidgets('should render SearchPage with input and headings',
      (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: BlocProvider<SearchBloc>.value(
          value: mockSearchBloc,
          child: SearchPage(),
        ),
      ),
    );

    expect(find.text('Search'), findsOneWidget);
    expect(find.text('Search Result Movies'), findsOneWidget);
    expect(find.text('Search Result Serial Tv'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });
}
