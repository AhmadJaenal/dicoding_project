import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'get_movie_recommendation_event.dart';
part 'get_movie_recommendation_state.dart';

class GetMovieRecommendationBloc
    extends Bloc<GetMovieRecommendationEvent, GetMovieRecommendationState> {
  final GetMovieRecommendations _getMovieRecommendation;
  GetMovieRecommendationBloc(this._getMovieRecommendation)
      : super(GetMovieRecommendationInitial()) {
    on<GetMovieRecommendationRequested>(_onRequested);
  }

  Future<void> _onRequested(
    GetMovieRecommendationRequested event,
    Emitter<GetMovieRecommendationState> emit,
  ) async {
    emit(GetMovieRecommendationLoading());

    final result = await _getMovieRecommendation.execute(event.id);

    result.fold(
      (failure) => emit(GetMovieRecommendationFailure(failure.message)),
      (data) => emit(GetMovieRecommendationLoaded(data)),
    );
  }
}
