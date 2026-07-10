import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:serialtv/domain/entities/serial_tv.dart';
import 'package:serialtv/domain/usecases/get_serial_tv.dart';

part 'get_serial_tv_popular_event.dart';
part 'get_serial_tv_popular_state.dart';

class GetSerialTvPopularBloc
    extends Bloc<GetSerialTvPopularEvent, GetSerialTVPopularState> {
  final GetSerialTV _getSerialTV;
  GetSerialTvPopularBloc(this._getSerialTV)
    : super(GetSerialTVPopularInitial()) {
    on<GetSerialTVPopularRequested>(_onRequested);
  }

  Future<void> _onRequested(
    GetSerialTVPopularRequested event,
    Emitter<GetSerialTVPopularState> emit,
  ) async {
    emit(GetSerialTVPopularLoading());

    final result = await _getSerialTV.execute();

    result.fold(
      (failure) => emit(GetSerialTVPopularFailure(failure.message)),
      (data) => emit(GetSerialTVPopularLoaded(data)),
    );
  }
}
