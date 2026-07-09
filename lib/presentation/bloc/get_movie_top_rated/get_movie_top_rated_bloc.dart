import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';

part 'get_movie_top_rated_event.dart';
part 'get_movie_top_rated_state.dart';

class GetMovieTopRatedBloc
    extends Bloc<GetMovieTopRatedEvent, GetMovieTopRatedState> {
  final GetTopRatedMovies _getTopRatedMovies;
  GetMovieTopRatedBloc(this._getTopRatedMovies)
      : super(GetMovieTopRatedInitial()) {
    on<GetMovieTopRatedRequested>(_onRequested);
  }

  Future<void> _onRequested(GetMovieTopRatedRequested event,
      Emitter<GetMovieTopRatedState> emit) async {
    emit(GetMovieTopRatedLoading());

    final result = await _getTopRatedMovies.execute();
    result.fold((failure) => emit(GetMovieTopRatedFailure(failure.message)),
        (response) => emit(GetMovieTopRatedLoaded(response)));
  }
}
