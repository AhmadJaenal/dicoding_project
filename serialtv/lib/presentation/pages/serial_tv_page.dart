import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:serialtv/presentation/bloc/get_serial_tv_popular/get_serial_tv_popular_bloc.dart';
import 'package:serialtv/presentation/widgets/serial_tv_card_list.dart';

class SerialTVPage extends StatefulWidget {
  static const ROUTE_NAME = '/serial-tv-page';

  @override
  _SerialTVPageState createState() => _SerialTVPageState();
}

class _SerialTVPageState extends State<SerialTVPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => context.read<GetSerialTvPopularBloc>().add(
        GetSerialTVPopularRequested(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Serial TV Page')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<GetSerialTvPopularBloc, GetSerialTVPopularState>(
          builder: (context, state) {
            if (state is GetSerialTVPopularLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is GetSerialTVPopularLoaded) {
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
