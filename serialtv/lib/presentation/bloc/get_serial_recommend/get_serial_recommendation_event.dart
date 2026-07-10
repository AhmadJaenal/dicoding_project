part of 'get_serial_recommendation_bloc.dart';

sealed class GetSerialRecommendationEvent extends Equatable {
  const GetSerialRecommendationEvent();

  @override
  List<Object> get props => [];
}

class GetSerialRecommendationRequested extends GetSerialRecommendationEvent {
  final int id;
  const GetSerialRecommendationRequested(this.id);

  @override
  List<Object> get props => [id];
}
