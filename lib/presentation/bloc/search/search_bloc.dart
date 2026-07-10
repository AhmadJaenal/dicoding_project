import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/search_movies.dart';
import 'package:ditonton/domain/usecases/search_serial_tv.dart';
import 'package:equatable/equatable.dart';
import 'package:serialtv/domain/entities/serial_tv.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies _searchMovies;
  final SerialTVSearch _serialTVSearch;

  SearchBloc(this._searchMovies, this._serialTVSearch)
      : super(SearchBlocInitial()) {
    on<OnQueryChanged>(_onRequested);
  }

  Future<void> _onRequested(
    OnQueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    emit(SearchLoading());

    final moviesResult = await _searchMovies.execute(event.query);
    final tvResult = await _serialTVSearch.execute(event.query);

    if (moviesResult.isLeft()) {
      emit(
        SearchFailure(
          moviesResult.swap().getOrElse(() => throw Exception()).message,
        ),
      );
      return;
    }

    if (tvResult.isLeft()) {
      emit(
        SearchFailure(
          tvResult.swap().getOrElse(() => throw Exception()).message,
        ),
      );
      return;
    }

    final movies = moviesResult.getOrElse(() => []);
    final serials = tvResult.getOrElse(() => []);

    if (movies.isEmpty && serials.isEmpty) {
      emit( SearchEmpty());
      return;
    }

    emit(
      SearchHasData(
        movies,
        serials,
      ),
    );
  }
}
