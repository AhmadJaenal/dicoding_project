part of 'get_movie_recommendation_bloc.dart';

sealed class GetMovieRecommendationState extends Equatable {
  const GetMovieRecommendationState();

  @override
  List<Object> get props => [];
}

final class GetMovieRecommendationInitial extends GetMovieRecommendationState {}

final class GetMovieRecommendationLoading extends GetMovieRecommendationState {}

final class GetMovieRecommendationLoaded extends GetMovieRecommendationState {
  final List<Movie> movies;
  const GetMovieRecommendationLoaded(this.movies);
}

final class GetMovieRecommendationFailure extends GetMovieRecommendationState {
  final String message;
  const GetMovieRecommendationFailure(this.message);
}
