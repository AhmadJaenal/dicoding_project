import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';

import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchListEvent, WatchListState> {
  final SaveWatchlist _saveWatchlistMovie;
  final RemoveWatchlist _removeWatchlistMovie;
  final GetWatchlistMovies _getWatchlistMovies;

  WatchlistBloc(
    this._saveWatchlistMovie,
    this._removeWatchlistMovie,
    this._getWatchlistMovies,
  ) : super(WatchListInitial()) {
    on<WatchlistAddDataMovie>(_onRequestedAddDataMovie);
    on<WatchlistRemoveDataMovie>(_onRequestedRemoveDataMovie);
    on<GetWatchlistRequested>(_onRequestWatchlist);
  }

  Future<void> _onRequestWatchlist(
      GetWatchlistRequested event, Emitter<WatchListState> emit) async {
    emit(GetWatchlistLoading());

    final result = await _getWatchlistMovies.execute();
    result.fold(
      (failure) => emit(GetWatchlistFailure(failure.message)),
      (response) {
        if (response.isNotEmpty) {
          emit(GetWatchlistHasData(response));
        } else {
          emit(GetWatchlistEmpty());
        }
      },
    );
  }

  Future<void> _onRequestedAddDataMovie(
      WatchlistAddDataMovie event, Emitter<WatchListState> emit) async {
    emit(WatchListLoading());

    final result = await _saveWatchlistMovie.execute(event.movieDetail);

    result.fold((failure) => emit(WatchListFailure(failure.message)),
        (response) => emit(WatchListAddDataSuccess(response)));
  }

  Future<void> _onRequestedRemoveDataMovie(
      WatchlistRemoveDataMovie event, Emitter<WatchListState> emit) async {
    emit(WatchListLoading());

    final result = await _removeWatchlistMovie.execute(event.movieDetail);

    result.fold((failure) => emit(WatchListFailure(failure.message)),
        (response) => emit(WatchListRemoveDataSuccess(response)));
  }
}
