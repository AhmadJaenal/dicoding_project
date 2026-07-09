import 'package:ditonton/presentation/bloc/get_serial_playing_now/get_serial_playing_now_bloc.dart';
import 'package:ditonton/presentation/widgets/serial_tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SerialTVPlayingNowPage extends StatefulWidget {
  static const ROUTE_NAME = '/serial-tv-playing-now';

  @override
  _SerialTVPlayingNowPageState createState() => _SerialTVPlayingNowPageState();
}

class _SerialTVPlayingNowPageState extends State<SerialTVPlayingNowPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context
        .read<GetSerialPlayingNowBloc>()
        .add(GetSerialPlayingNowRequested()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Serial TV Playing Now'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<GetSerialPlayingNowBloc, GetSerialPlayingNowState>(
          builder: (context, state) {
            if (state is GetSerialPlayingNowLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is GetSerialPlayingNowLoaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final movie = state.serials[index];
                  return SerialTVCard(movie);
                },
                itemCount: state.serials.length,
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
