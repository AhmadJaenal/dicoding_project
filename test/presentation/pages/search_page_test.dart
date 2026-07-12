import 'package:ditonton/presentation/bloc/search/search_bloc.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockSearchBloc mockSearchBloc;

  setUpAll(() {
    provideDummy<SearchState>(SearchBlocInitial());
  });

  setUp(() {
    mockSearchBloc = MockSearchBloc();
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

  Widget _makeTestableWidget(Widget body) {
    return MaterialApp(
      home: BlocProvider<SearchBloc>.value(
        value: mockSearchBloc,
        child: body,
      ),
    );
  }

  void _stubState(SearchState state) {
    when(mockSearchBloc.state).thenReturn(state);
    when(mockSearchBloc.stream).thenAnswer((_) => Stream.value(state));
  }

  testWidgets('should render SearchPage with input and headings',
      (tester) async {
    _stubState(SearchBlocInitial());

    await tester.pumpWidget(_makeTestableWidget(SearchPage()));

    expect(find.text('Search'), findsOneWidget);
    expect(find.text('Search Result Movies'), findsOneWidget);
    expect(find.text('Search Result Serial Tv'), findsOneWidget);
    expect(find.byType(TextField), findsOneWidget);
  });

  testWidgets('TextField onChanged should add OnQueryChanged event to the bloc',
      (tester) async {
    _stubState(SearchBlocInitial());

    await tester.pumpWidget(_makeTestableWidget(SearchPage()));

    await tester.enterText(find.byType(TextField), 'batman');
    await tester.pump();

    verify(mockSearchBloc.add(const OnQueryChanged('batman'))).called(1);
  });

  testWidgets('should submit search from keyboard action without throwing',
      (tester) async {
    _stubState(SearchBlocInitial());

    await tester.pumpWidget(_makeTestableWidget(SearchPage()));

    await tester.enterText(find.byType(TextField), 'batman');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pump();

    expect(tester.takeException(), isNull);
  });

  group('Movies & Serial TV section - Loading', () {
    testWidgets('should display CircularProgressIndicator when loading',
        (tester) async {
      _stubState(SearchLoading());

      await tester.pumpWidget(_makeTestableWidget(SearchPage()));

      expect(find.byType(CircularProgressIndicator), findsNWidgets(2));
    });
  });

  group('Movies & Serial TV section - HasData', () {
    testWidgets('should display ListView with movie and serial tv cards',
        (tester) async {
      _stubState(SearchHasData(testMovieList, tSerialTVList));

      await tester.pumpWidget(_makeTestableWidget(SearchPage()));
      await tester.pump();

      expect(find.byType(ListView), findsNWidgets(2));
    });
  });

  group('Movies & Serial TV section - Empty', () {
    testWidgets("should display 'Tidak ada' when result is empty",
        (tester) async {
      _stubState(SearchEmpty());

      await tester.pumpWidget(_makeTestableWidget(SearchPage()));

      expect(find.text('Tidak ada'), findsNWidgets(2));
    });
  });

  group('Movies & Serial TV section - Failed / else branch', () {
    testWidgets("should display 'Failed' text for other states",
        (tester) async {
      _stubState(const SearchFailure('Server Failure'));

      await tester.pumpWidget(_makeTestableWidget(SearchPage()));

      expect(find.text('Failed'), findsNWidgets(2));
    });
  });
}
