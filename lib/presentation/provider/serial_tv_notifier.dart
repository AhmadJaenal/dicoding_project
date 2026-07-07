import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/serial_tv.dart';
import 'package:ditonton/domain/usecases/get_serial_tv.dart';
import 'package:flutter/foundation.dart';

class SerialTVNotifier extends ChangeNotifier {
  final GetSerialTV getSerialTV;

  SerialTVNotifier({required this.getSerialTV});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<SerialTV> _serialTV = [];
  List<SerialTV> get serialTV => _serialTV;

  String _message = '';
  String get message => _message;

  Future<void> fetchSerialTV() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getSerialTV.execute();

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
