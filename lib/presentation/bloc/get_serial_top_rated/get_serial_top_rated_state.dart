part of 'get_serial_top_rated_bloc.dart';

sealed class GetSerialTopRatedState extends Equatable {
  const GetSerialTopRatedState();

  @override
  List<Object> get props => [];
}

final class GetSerialTopRatedInitial extends GetSerialTopRatedState {}

final class GetSerialTopRatedLoading extends GetSerialTopRatedState {}

final class GetSerialTopRatedLoaded extends GetSerialTopRatedState {
  final List<SerialTV> serials;
  const GetSerialTopRatedLoaded(this.serials);
}

final class GetSerialTopRatedFailure extends GetSerialTopRatedState {
  final String message;
  const GetSerialTopRatedFailure(this.message);
}
