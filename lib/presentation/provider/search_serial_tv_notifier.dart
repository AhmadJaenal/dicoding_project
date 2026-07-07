import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/serial_tv.dart';
import 'package:ditonton/domain/usecases/search_serial_tv.dart';
import 'package:flutter/foundation.dart';

class SerialSearchNotifier extends ChangeNotifier {
  final SerialTVSearch searchSerial;

  SerialSearchNotifier({required this.searchSerial});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<SerialTV> _searchResult = [];
  List<SerialTV> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchSerialTVSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchSerial.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _searchResult = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
