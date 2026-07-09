import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/presentation/bloc/get_movie_top_rated/get_movie_top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/get_serial_playing_now/get_serial_playing_now_bloc.dart';
import 'package:ditonton/presentation/bloc/get_serial_top_rated/get_serial_top_rated_bloc.dart';
import 'package:ditonton/presentation/bloc/get_playing_now_movie/get_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/get_popular_movie/get_popular_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/get_serial_tv_popular/get_serial_tv_popular_bloc.dart';
import 'package:ditonton/presentation/pages/about_page.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/presentation/pages/now_playing_page.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/presentation/pages/search_page.dart';
import 'package:ditonton/presentation/pages/serial_tv_detail_page.dart';
import 'package:ditonton/presentation/pages/serial_tv_page.dart';
import 'package:ditonton/presentation/pages/serial_tv_playing_now_page.dart';
import 'package:ditonton/presentation/pages/serial_tv_top_rated_page.dart';
import 'package:ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/presentation/pages/watchlist_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/serial_tv.dart';

class HomeMoviePage extends StatefulWidget {
  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<GetMovieBloc>().add(const GetMovieEventRequested());
      context.read<GetMovieTopRatedBloc>().add(GetMovieTopRatedRequested());
      context.read<GetPopularMovieBloc>().add(const GetPopularMovieRequsted());
      context.read<GetSerialTopRatedBloc>().add(GetSerialTopRequested());
      context.read<GetSerialTvPopularBloc>().add(GetSerialTVPopularRequested());
      context
          .read<GetSerialPlayingNowBloc>()
          .add(GetSerialPlayingNowRequested());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/circle-g.png'),
                backgroundColor: Colors.grey.shade900,
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
              decoration: BoxDecoration(
                color: Colors.grey.shade900,
              ),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
              },
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'Now Playing',
                onTap: () =>
                    Navigator.pushNamed(context, NowPlayingPage.ROUTE_NAME),
              ),
              BlocBuilder<GetMovieBloc, GetMovieState>(
                builder: (contenxt, state) {
                  if (state is GetMovieLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is GetMovieLoaded) {
                    return MovieList(state.movies);
                  } else {
                    return Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<GetPopularMovieBloc, GetPopularMovieState>(
                builder: (context, state) {
                  if (state is GetPopularMovieLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is GetPopularMovieLoaded) {
                    return MovieList(state.movies);
                  } else {
                    return Text('Failed');
                  }
                },
              ),
              // }),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<GetMovieTopRatedBloc, GetMovieTopRatedState>(
                builder: (context, state) {
                  if (state is GetMovieTopRatedLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is GetMovieTopRatedLoaded) {
                    return MovieList(state.movies);
                  } else {
                    return Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Serial Tv Popular',
                onTap: () =>
                    Navigator.pushNamed(context, SerialTVPage.ROUTE_NAME),
              ),
              BlocBuilder<GetSerialTvPopularBloc, GetSerialTVPopularState>(
                  builder: (context, state) {
                if (state is GetSerialTVPopularLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is GetSerialTVPopularLoaded) {
                  return SerialTVList(state.serials);
                } else {
                  return Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Serial Tv Top Rated',
                onTap: () => Navigator.pushNamed(
                    context, SerialTVTopRatedPage.ROUTE_NAME),
              ),
              BlocBuilder<GetSerialTopRatedBloc, GetSerialTopRatedState>(
                  builder: (context, state) {
                if (state is GetSerialTopRatedLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state is GetSerialTopRatedLoaded) {
                  return SerialTVList(state.serials);
                } else {
                  return Text('Failed');
                }
              }),
              _buildSubHeading(
                title: 'Serial Tv Playing Now',
                onTap: () => Navigator.pushNamed(
                    context, SerialTVPlayingNowPage.ROUTE_NAME),
              ),
              BlocBuilder<GetSerialPlayingNowBloc, GetSerialPlayingNowState>(
                  builder: (context, state) {
                if (state is GetSerialPlayingNowLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is GetSerialPlayingNowLoaded) {
                  return SerialTVList(state.serials);
                } else {
                  return Text('Failed');
                }
              })
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: heading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}

class SerialTVList extends StatelessWidget {
  final List<SerialTV> serialTV;

  SerialTVList(this.serialTV);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = serialTV[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  SerialTVDetail.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: serialTV.length,
      ),
    );
  }
}
