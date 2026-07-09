import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/serial_tv.dart';
import 'package:ditonton/domain/usecases/get_serial_tv_top_rated.dart';
import 'package:equatable/equatable.dart';

part 'get_serial_top_rated_event.dart';
part 'get_serial_top_rated_state.dart';

class GetSerialTopRatedBloc
    extends Bloc<GetSerialTopRatedEvent, GetSerialTopRatedState> {
  final GetSerialTVTopRated _getSerialTVTopRated;
  GetSerialTopRatedBloc(this._getSerialTVTopRated)
      : super(GetSerialTopRatedInitial()) {
    on<GetSerialTopRequested>(_onRequested);
  }

  Future<void> _onRequested(
      GetSerialTopRequested event, Emitter<GetSerialTopRatedState> emit) async {
    emit(GetSerialTopRatedLoading());
    final result = await _getSerialTVTopRated.execute();

    result.fold((failure) => emit(GetSerialTopRatedFailure(failure.message)),
        (data) => emit(GetSerialTopRatedLoaded(data)));
  }
}
