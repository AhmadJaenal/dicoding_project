import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:equatable/equatable.dart';

part 'get_popular_movie_event.dart';
part 'get_popular_movie_state.dart';

class GetPopularMovieBloc
    extends Bloc<GetPopularMovieEvent, GetPopularMovieState> {
  final GetPopularMovies _getPopularMovies;
  GetPopularMovieBloc(this._getPopularMovies)
      : super(GetPopularMovieInitial()) {
    on<GetPopularMovieRequsted>(_onRequested);
  }

  Future<void> _onRequested(
      GetPopularMovieRequsted event, Emitter<GetPopularMovieState> emit) async {
    emit(GetPopularMovieLoading());

    final result = await _getPopularMovies.execute();

    result.fold((failure) => emit(GetPopularMovieFailure(failure.message)),
        (data) => emit(GetPopularMovieLoaded(data)));
  }
}
