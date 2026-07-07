import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/serial_tv.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/serial_tv_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

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
      final notifier =
          Provider.of<SerialTVDetailNotifier>(context, listen: false);

      notifier.fetchSerialTVDetail(widget.id);
      notifier.loadWatchlistStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<SerialTVDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.state == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.state == RequestState.Loaded) {
            final SerialTV = provider.serialTV;
            return SafeArea(
              child: DetailContent(
                SerialTV,
                provider.serialTVRecommendations,
                provider.isAddedToWatchlist,
              ),
            );
          } else {
            return Text(provider.message);
          }
        },
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
                                  await Provider.of<SerialTVDetailNotifier>(
                                          context,
                                          listen: false)
                                      .addWatchlist(serialTV);
                                } else {
                                  await Provider.of<SerialTVDetailNotifier>(
                                          context,
                                          listen: false)
                                      .removeFromWatchlist(serialTV);
                                }

                                final message =
                                    Provider.of<SerialTVDetailNotifier>(context,
                                            listen: false)
                                        .watchlistMessage;

                                if (message ==
                                        SerialTVDetailNotifier
                                            .watchlistAddSuccessMessage ||
                                    message ==
                                        SerialTVDetailNotifier
                                            .watchlistRemoveSuccessMessage) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message)));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
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
                            Consumer<SerialTVDetailNotifier>(
                              builder: (context, data, child) {
                                if (data.recommendationState ==
                                    RequestState.Loading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (data.recommendationState ==
                                    RequestState.Error) {
                                  return Text(data.message);
                                } else if (data.recommendationState ==
                                    RequestState.Loaded) {
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final movie = recommendations[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                SerialTVDetail.ROUTE_NAME,
                                                arguments: movie.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: recommendations.length,
                                    ),
                                  );
                                } else {
                                  return Container();
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
