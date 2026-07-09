import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';

part 'get_movie_event.dart';
part 'get_movie_state.dart';

class GetMovieBloc extends Bloc<GetMovieEvent, GetMovieState> {
  final GetNowPlayingMovies _getNowPlayingMovies;

  GetMovieBloc(this._getNowPlayingMovies) : super(GetMovieInitial()) {
    on<GetMovieEventRequested>(_onRequested);
  }

  Future<void> _onRequested(
      GetMovieEventRequested event, Emitter<GetMovieState> emit) async {
    emit(GetMovieLoading());

    final result = await _getNowPlayingMovies.execute();

    result.fold((failure) => emit(GetMovieError(failure.message)),
        (data) => emit(GetMovieLoaded(data)));
  }
}
