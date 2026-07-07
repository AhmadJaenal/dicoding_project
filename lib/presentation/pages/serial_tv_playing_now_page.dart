import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/serial_tv_playing_now_notifier.dart';
import 'package:ditonton/presentation/widgets/serial_tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SerialTVPlayingNowPage extends StatefulWidget {
  static const ROUTE_NAME = '/serial-tv-playing-now';

  @override
  _SerialTVPlayingNowPageState createState() => _SerialTVPlayingNowPageState();
}

class _SerialTVPlayingNowPageState extends State<SerialTVPlayingNowPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<SerialTVPlayingNowNotifier>(context, listen: false)
            .fetchSerialTVPlayingNow());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Serial TV Playing Now'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<SerialTVPlayingNowNotifier>(
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
