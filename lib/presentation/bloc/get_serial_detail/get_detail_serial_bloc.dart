import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/serial_tv.dart';
import 'package:ditonton/domain/usecases/get_serial_tv_detail.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status_serial_tv.dart';
import 'package:equatable/equatable.dart';

part 'get_detail_serial_event.dart';
part 'get_detail_serial_state.dart';

class GetDetailSerialBloc
    extends Bloc<GetDetailSerialEvent, GetDetailSerialState> {
  final GetSerialTVDetail _getSerialDetail;
  final GetWatchListStatusSerialTV _getWatchListStatus;

  GetDetailSerialBloc(
    this._getSerialDetail,
    this._getWatchListStatus,
  ) : super(GetDetailSerialInitial()) {
    on<GetDetailSerialRequested>(_onRequested);
    on<GetStatusWatchlistSerialRequested>(_onStatusRequested);
  }

  Future<void> _onRequested(GetDetailSerialRequested event,
      Emitter<GetDetailSerialState> emit) async {
    emit(GetDetailSerialLoading());

    final result = await _getSerialDetail.execute(event.id);
    await result.fold(
      (failure) async {
        emit(GetDetailSerialFailure(failure.message));
      },
      (serial) async {
        final status = await _getWatchListStatus.execute(serial.id);

        emit(
          GetDetailSerialLoaded(
            serial,
            isAddedToWatchlist: status,
          ),
        );
      },
    );
  }

  Future<void> _onStatusRequested(GetStatusWatchlistSerialRequested event,
      Emitter<GetDetailSerialState> emit) async {
    final currentState = state;
    if (currentState is GetDetailSerialLoaded) {
      final status = await _getWatchListStatus.execute(event.id);
      emit(currentState.copyWith(isAddedToWatchlist: status));
    }
  }
}
