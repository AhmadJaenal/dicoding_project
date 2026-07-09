part of 'get_detail_movie_bloc.dart';

sealed class GetDetailMovieState extends Equatable {
  const GetDetailMovieState();

  @override
  List<Object> get props => [];
}

final class GetDetailMovieInitial extends GetDetailMovieState {}

final class GetDetailMovieLoading extends GetDetailMovieState {}

final class GetDetailMovieLoaded extends GetDetailMovieState {
  final MovieDetail movie;
  final bool isAddedToWatchlist;

  const GetDetailMovieLoaded(
    this.movie, {
    this.isAddedToWatchlist = false,
  });

  GetDetailMovieLoaded copyWith({
    MovieDetail? movie,
    bool? isAddedToWatchlist,
  }) {
    return GetDetailMovieLoaded(
      movie ?? this.movie,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
    );
  }

  @override
  List<Object> get props => [movie, isAddedToWatchlist];
}

final class GetDetailMovieFailure extends GetDetailMovieState {
  final String message;
  const GetDetailMovieFailure(this.message);
}
