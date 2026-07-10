import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serialtv/presentation/bloc/get_serial_top_rated/get_serial_top_rated_bloc.dart';
import 'package:serialtv/presentation/widgets/serial_tv_card_list.dart';

class SerialTVTopRatedPage extends StatefulWidget {
  static const ROUTE_NAME = '/serial-tv-top-rated';

  @override
  _SerialTVTopRatedPageState createState() => _SerialTVTopRatedPageState();
}

class _SerialTVTopRatedPageState extends State<SerialTVTopRatedPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<GetSerialTopRatedBloc>().add(GetSerialTopRequested()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Serial TV Top Rated')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<GetSerialTopRatedBloc, GetSerialTopRatedState>(
          builder: (context, state) {
            if (state is GetSerialTopRatedLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is GetSerialTopRatedLoaded) {
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
