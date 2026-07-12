part of 'get_movie_recommendation_bloc.dart';

sealed class GetMovieRecommendationEvent extends Equatable {
  const GetMovieRecommendationEvent();
}

class GetMovieRecommendationRequested extends GetMovieRecommendationEvent {
  final int id;
  const GetMovieRecommendationRequested(this.id);

  @override
  List<Object> get props => [id];
}
