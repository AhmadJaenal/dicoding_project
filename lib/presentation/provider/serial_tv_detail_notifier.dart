import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/serial_tv.dart';
import 'package:ditonton/domain/usecases/get_serial_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_serial_tv_recommedations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_serial_tv.dart';
import 'package:ditonton/domain/usecases/remove_watchlist_serial_tv.dart';
import 'package:ditonton/domain/usecases/save_watchlist_serial_tv.dart';
import 'package:flutter/foundation.dart';

class SerialTVDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetSerialTVDetail getSerialTVDetail;
  final GetSerialTVRecommendations getSerialeRecommendations;
  final GetWatchListStatusSerialTV getWatchListStatus;
  final SaveWatchlistSerial saveWatchlist;
  final RemoveWatchlistSerialTV removeWatchlist;

  SerialTVDetailNotifier({
    required this.getSerialTVDetail,
    required this.getSerialeRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  });

  late SerialTV _serialTV;
  late List<SerialTV> _serialTVRecommendations;

  SerialTV get serialTV => _serialTV;
  List<SerialTV> get serialTVRecommendations => _serialTVRecommendations;

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  Future<void> fetchSerialTVDetail(int id) async {
    _state = RequestState.Loading;
    notifyListeners();

    final detailResult = await getSerialTVDetail.execute(id);
    final recommendationResult = await getSerialeRecommendations.execute();

    detailResult.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
      (SerialTV) {
        _serialTV = SerialTV;
        _state = RequestState.Loaded;
        recommendationResult.fold(
          (failure) {
            _recommendationState = RequestState.Error;
            _message = failure.message;
          },
          (SerialTVRecommendations) {
            _serialTVRecommendations = SerialTVRecommendations;
            _recommendationState = RequestState.Loaded;
          },
        );
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(SerialTV movie) async {
    final result = await saveWatchlist.execute(movie);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(movie.id);
  }

  Future<void> removeFromWatchlist(SerialTV movie) async {
    final result = await removeWatchlist.execute(movie);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(movie.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
