import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/serial_tv_top_rated_notifier.dart';
import 'package:ditonton/presentation/widgets/serial_tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SerialTVTopRatedPage extends StatefulWidget {
  static const ROUTE_NAME = '/serial-tv-top-rated';

  @override
  _SerialTVTopRatedPageState createState() => _SerialTVTopRatedPageState();
}

class _SerialTVTopRatedPageState extends State<SerialTVTopRatedPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<SerialTVTopRatedNotifier>(context, listen: false)
            .fetchSerialTVTopRated());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Serial TV Top Rated'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<SerialTVTopRatedNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = data.serialTV[index];
                  return SerialTVCard(movie);
                },
                itemCount: data.serialTV.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(data.message),
              );
            }
          },
        ),
      ),
    );
  }
}
