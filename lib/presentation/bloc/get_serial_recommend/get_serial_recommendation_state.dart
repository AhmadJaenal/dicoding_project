part of 'get_serial_recommendation_bloc.dart';

sealed class GetSerialRecommendationState extends Equatable {
  const GetSerialRecommendationState();

  @override
  List<Object> get props => [];
}

final class GetSerialRecommendationInitial
    extends GetSerialRecommendationState {}

final class GetSerialRecommendationLoading
    extends GetSerialRecommendationState {}

final class GetSerialRecommendationLoaded extends GetSerialRecommendationState {
  final List<SerialTV> serials;
  const GetSerialRecommendationLoaded(this.serials);
}

final class GetSerialRecommendationFailure
    extends GetSerialRecommendationState {
  final String message;
  const GetSerialRecommendationFailure(this.message);
}
