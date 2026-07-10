import 'package:core/utils/utils.dart';
import 'package:ditonton/presentation/bloc/watchlist/watchlist_bloc.dart';
import 'package:ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serialtv/domain/entities/serial_tv.dart';
import 'package:serialtv/presentation/widgets/serial_tv_card_list.dart';

class WatchlistMoviesPage extends StatefulWidget {
  static const ROUTE_NAME = '/watchlist-movie';

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(
        () => context.read<WatchlistBloc>().add(GetWatchlistRequested()));
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    context.read<WatchlistBloc>().add(
          GetWatchlistRequested(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Watchlist'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistBloc, WatchListState>(
          builder: (context, state) {
            if (state is GetWatchlistLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetWatchlistEmpty) {
              return Center(
                child: Text('Your watchlist empty'),
              );
            } else if (state is GetWatchlistHasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.movies[index];
                  if (movie.isMovie == 1) {
                    return MovieCard(movie);
                  } else {
                    return SerialTVCard(
                      SerialTV.watchlist(
                        isMovie: 1,
                        id: movie.id,
                        name: movie.title ?? '-',
                        overview: movie.overview ?? '-',
                        posterPath: movie.posterPath,
                      ),
                    );
                  }
                },
                itemCount: state.movies.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text('Failed'),
              );
            }
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }
}
