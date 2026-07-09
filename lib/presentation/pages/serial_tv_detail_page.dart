import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/serial_tv.dart';
import 'package:ditonton/presentation/bloc/get_serial_detail/get_detail_serial_bloc.dart';
import 'package:ditonton/presentation/bloc/get_serial_recommend/get_serial_recommendation_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist/watchlist_bloc.dart';
import 'package:ditonton/presentation/widgets/cache_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class SerialTVDetail extends StatefulWidget {
  static const ROUTE_NAME = '/serial-tv-detail';

  final int id;
  SerialTVDetail({required this.id});

  @override
  _SerialTVDetailState createState() => _SerialTVDetailState();
}

class _SerialTVDetailState extends State<SerialTVDetail> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context
          .read<GetDetailSerialBloc>()
          .add(GetDetailSerialRequested(widget.id));
      context
          .read<GetSerialRecommendationBloc>()
          .add(GetSerialRecommendationRequested(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<WatchlistBloc, WatchListState>(
      listener: (context, watchlistState) {
        if (watchlistState is WatchListAddDataSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(watchlistState.message),
            ),
          );

          context.read<GetDetailSerialBloc>().add(
                GetStatusWatchlistSerialRequested(widget.id),
              );
        }

        if (watchlistState is WatchListFailure) {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              content: Text(watchlistState.message),
            ),
          );
        }
      },
      child: Scaffold(
        body: BlocBuilder<GetDetailSerialBloc, GetDetailSerialState>(
          builder: (context, state) {
            if (state is GetDetailSerialLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is GetDetailSerialLoaded) {
              return BlocBuilder<GetSerialRecommendationBloc,
                  GetSerialRecommendationState>(
                builder: (context, recommendationState) {
                  if (recommendationState is GetSerialRecommendationLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (recommendationState is GetSerialRecommendationLoaded) {
                    return SafeArea(
                      child: DetailContent(
                        state.serial,
                        recommendationState.serials,
                        state.isAddedToWatchlist,
                      ),
                    );
                  }

                  if (recommendationState is GetSerialRecommendationFailure) {
                    return Center(
                      child: Text('recommendationState.message'),
                    );
                  }

                  return const SizedBox.shrink();
                },
              );
            }

            if (state is GetDetailSerialFailure) {
              return Center(
                child: Text('state.message'),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final SerialTV serialTV;
  final List<SerialTV> recommendations;
  final bool isAddedWatchlist;

  DetailContent(this.serialTV, this.recommendations, this.isAddedWatchlist);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: 'https://image.tmdb.org/t/p/w500${serialTV.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: richBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              serialTV.name,
                              style: heading5,
                            ),
                            FilledButton(
                              onPressed: () async {
                                if (!isAddedWatchlist) {
                                  context
                                      .read<WatchlistBloc>()
                                      .add(WatchlistAddDataSerial(serialTV));
                                } else {
                                  context
                                      .read<WatchlistBloc>()
                                      .add(WatchlistRemoveDataSerial(serialTV));
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isAddedWatchlist
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: serialTV.voteAverage! / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: mikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${serialTV.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: heading6,
                            ),
                            Text(
                              serialTV.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: heading6,
                            ),
                            BlocBuilder<GetSerialRecommendationBloc,
                                GetSerialRecommendationState>(
                              builder: (context, state) {
                                if (state is GetSerialRecommendationLoading) {
                                  return Center(
                                      child: CircularProgressIndicator());
                                } else if (state
                                    is GetSerialRecommendationLoaded) {
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final serial = recommendations[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                SerialTVDetail.ROUTE_NAME,
                                                arguments: serial.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CustomCacheImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${serial.posterPath}',
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: recommendations.length,
                                    ),
                                  );
                                } else {
                                  return Text('Failed');
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: richBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }
}
