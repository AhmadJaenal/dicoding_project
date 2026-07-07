import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/serial_tv_notifier.dart';
import 'package:ditonton/presentation/widgets/serial_tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SerialTVPage extends StatefulWidget {
  static const ROUTE_NAME = '/serial-tv-page';

  @override
  _SerialTVPageState createState() => _SerialTVPageState();
}

class _SerialTVPageState extends State<SerialTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<SerialTVNotifier>(context, listen: false).fetchSerialTV());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Serial TV Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<SerialTVNotifier>(
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
