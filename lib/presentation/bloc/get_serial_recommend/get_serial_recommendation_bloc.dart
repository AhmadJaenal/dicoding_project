import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/serial_tv.dart';
import 'package:ditonton/domain/usecases/get_serial_tv_recommedations.dart';
import 'package:equatable/equatable.dart';

part 'get_serial_recommendation_event.dart';
part 'get_serial_recommendation_state.dart';

class GetSerialRecommendationBloc
    extends Bloc<GetSerialRecommendationEvent, GetSerialRecommendationState> {
  GetSerialTVRecommendations _getSerialTVRecommendations;

  GetSerialRecommendationBloc(this._getSerialTVRecommendations)
      : super(GetSerialRecommendationInitial()) {
    on<GetSerialRecommendationRequested>(_onRequested);
  }

  Future<void> _onRequested(
    GetSerialRecommendationRequested event,
    Emitter<GetSerialRecommendationState> emit,
  ) async {
    emit(GetSerialRecommendationLoading());

    final result = await _getSerialTVRecommendations.execute();

    result.fold(
      (failure) => emit(GetSerialRecommendationFailure(failure.message)),
      (data) => emit(GetSerialRecommendationLoaded(data)),
    );
  }
}
