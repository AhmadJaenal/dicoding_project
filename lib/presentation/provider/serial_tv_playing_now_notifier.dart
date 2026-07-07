import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/serial_tv.dart';
import 'package:ditonton/domain/usecases/get_serial_tv_playing_now.dart';
import 'package:flutter/foundation.dart';

class SerialTVPlayingNowNotifier extends ChangeNotifier {
  final GetSerialTVPlayingNow getSerialTVPlayingNow;

  SerialTVPlayingNowNotifier({required this.getSerialTVPlayingNow});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<SerialTV> _serialTV = [];
  List<SerialTV> get serialTV => _serialTV;

  String _message = '';
  String get message => _message;

  Future<void> fetchSerialTVPlayingNow() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getSerialTVPlayingNow.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (SerialTV) {
        _serialTV = SerialTV;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
