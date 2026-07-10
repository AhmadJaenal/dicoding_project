import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:serialtv/domain/entities/serial_tv.dart';
import 'package:serialtv/domain/usecases/remove_watchlist_serial_tv.dart';
import 'package:serialtv/domain/usecases/save_watchlist_serial_tv.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistSerialTVBloc extends Bloc<WatchListEvent, WatchListState> {
  final SaveWatchlistSerial _saveWatchlistSerial;
  final RemoveWatchlistSerialTV _removeWatchlistSerial;

  WatchlistSerialTVBloc(this._saveWatchlistSerial, this._removeWatchlistSerial)
    : super(WatchListInitial()) {
    on<WatchlistAddDataSerial>(_onRequestedAddDataSerialTV);
    on<WatchlistRemoveDataSerial>(_onRequestedRemoveSerial);
  }

  Future<void> _onRequestedAddDataSerialTV(
    WatchlistAddDataSerial event,
    Emitter<WatchListState> emit,
  ) async {
    emit(WatchListLoading());

    final result = await _saveWatchlistSerial.execute(event.serialDetail);

    result.fold(
      (failure) => emit(WatchListFailure(failure.message)),
      (response) => emit(WatchListAddDataSuccess(response)),
    );
  }

  Future<void> _onRequestedRemoveSerial(
    WatchlistRemoveDataSerial event,
    Emitter<WatchListState> emit,
  ) async {
    emit(WatchListLoading());

    final result = await _removeWatchlistSerial.execute(event.serialTVDetail);

    result.fold(
      (failure) => emit(WatchListFailure(failure.message)),
      (response) => emit(WatchListRemoveDataSuccess(response)),
    );
  }
}
