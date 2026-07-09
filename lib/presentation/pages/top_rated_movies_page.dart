import 'package:ditonton/presentation/bloc/get_movie_recommendation/get_movie_recommendation_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopRatedMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/top-rated-movie';

  @override
  _TopRatedMoviesPageState createState() => _TopRatedMoviesPageState();
}

class _TopRatedMoviesPageState extends State<TopRatedMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context
        .read<GetMovieRecommendationBloc>()
        .add(const GetMovieRecommendationRequested(1221)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<GetMovieRecommendationBloc,
            GetMovieRecommendationState>(
          builder: (context, state) {
            if (state is GetMovieRecommendationLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is GetMovieRecommendationLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.movies[index];
                  return MovieCard(movie);
                },
                itemCount: state.movies.length,
              );
            } else {
              return Text('Failed');
            }
          },
        ),
      ),
    );
  }
}
