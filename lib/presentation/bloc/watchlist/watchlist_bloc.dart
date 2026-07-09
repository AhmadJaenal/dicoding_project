import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/serial_tv.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_serial_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist_serial_tv.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchListEvent, WatchListState> {
  final SaveWatchlist _saveWatchlistMovie;
  final SaveWatchlistSerial _saveWatchlistSerial;
  final RemoveWatchlist _removeWatchlistMovie;
  final RemoveWatchlistSerialTV _removeWatchlistSerial;
  final GetWatchlistMovies _getWatchlistMovies;

  WatchlistBloc(
    this._saveWatchlistMovie,
    this._saveWatchlistSerial,
    this._removeWatchlistMovie,
    this._removeWatchlistSerial,
    this._getWatchlistMovies,
  ) : super(WatchListInitial()) {
    on<WatchlistAddDataMovie>(_onRequestedAddDataMovie);
    on<WatchlistAddDataSerial>(_onRequestedAddDataSerialTV);
    on<WatchlistRemoveDataMovie>(_onRequestedRemoveDataMovie);
    on<WatchlistRemoveDataSerial>(_onRequestedRemoveSerial);
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

  Future<void> _onRequestedAddDataSerialTV(
      WatchlistAddDataSerial event, Emitter<WatchListState> emit) async {
    emit(WatchListLoading());

    final result = await _saveWatchlistSerial.execute(event.serialDetail);

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

  Future<void> _onRequestedRemoveSerial(
      WatchlistRemoveDataSerial event, Emitter<WatchListState> emit) async {
    emit(WatchListLoading());

    final result = await _removeWatchlistSerial.execute(event.serialTVDetail);

    result.fold((failure) => emit(WatchListFailure(failure.message)),
        (response) => emit(WatchListRemoveDataSuccess(response)));
  }
}
