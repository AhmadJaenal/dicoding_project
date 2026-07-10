import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:serialtv/domain/entities/serial_tv.dart';
import 'package:serialtv/domain/usecases/get_serial_tv_playing_now.dart';

part 'get_serial_playing_now_event.dart';
part 'get_serial_playing_now_state.dart';

class GetSerialPlayingNowBloc
    extends Bloc<GetSerialPlayingNowEvent, GetSerialPlayingNowState> {
  final GetSerialTVPlayingNow _getSerialTVPlayingNow;
  GetSerialPlayingNowBloc(this._getSerialTVPlayingNow)
    : super(GetSerialPlayingNowInitial()) {
    on<GetSerialPlayingNowRequested>(_onRequested);
  }

  Future<void> _onRequested(
    GetSerialPlayingNowRequested event,
    Emitter<GetSerialPlayingNowState> emit,
  ) async {
    emit(GetSerialPlayingNowLoading());

    final result = await _getSerialTVPlayingNow.execute();

    result.fold(
      (failure) => emit(GetSerialPlayingNowFailure(failure.message)),
      (data) => emit(GetSerialPlayingNowLoaded(data)),
    );
  }
}
