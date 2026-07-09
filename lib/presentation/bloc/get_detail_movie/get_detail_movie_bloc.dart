import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:equatable/equatable.dart';

part 'get_detail_movie_event.dart';
part 'get_detail_movie_state.dart';

class GetDetailMovieBloc
    extends Bloc<GetDetailMovieEvent, GetDetailMovieState> {
  final GetMovieDetail _getMovieDetail;
  final GetWatchListStatus _getWatchListStatus;
  GetDetailMovieBloc(this._getMovieDetail, this._getWatchListStatus)
      : super(GetDetailMovieInitial()) {
    on<GetDetailMovieRequested>(_onRequested);
  }

  Future<void> _onRequested(
    GetDetailMovieRequested event,
    Emitter<GetDetailMovieState> emit,
  ) async {
    emit(GetDetailMovieLoading());

    final result = await _getMovieDetail.execute(event.id);

    await result.fold(
      (failure) async {
        emit(GetDetailMovieFailure(failure.message));
      },
      (movie) async {
        final status = await _getWatchListStatus.execute(movie.id);

        emit(
          GetDetailMovieLoaded(
            movie,
            isAddedToWatchlist: status,
          ),
        );
      },
    );
  }
}
