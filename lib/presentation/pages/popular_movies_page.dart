import 'package:ditonton/presentation/bloc/get_popular_movie/get_popular_movie_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PopularMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/popular-movie';

  @override
  _PopularMoviesPageState createState() => _PopularMoviesPageState();
}

class _PopularMoviesPageState extends State<PopularMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context
        .read<GetPopularMovieBloc>()
        .add(const GetPopularMovieRequsted()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<GetPopularMovieBloc, GetPopularMovieState>(
          builder: (context, state) {
            if (state is GetPopularMovieLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is GetPopularMovieLoaded) {
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
