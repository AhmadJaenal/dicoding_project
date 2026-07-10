part of 'get_serial_tv_popular_bloc.dart';

sealed class GetSerialTVPopularState extends Equatable {
  const GetSerialTVPopularState();

  @override
  List<Object> get props => [];
}

final class GetSerialTVPopularInitial extends GetSerialTVPopularState {}

final class GetSerialTVPopularLoading extends GetSerialTVPopularState {}

final class GetSerialTVPopularLoaded extends GetSerialTVPopularState {
  final List<SerialTV> serials;
  const GetSerialTVPopularLoaded(this.serials);
}

final class GetSerialTVPopularFailure extends GetSerialTVPopularState {
  final String message;
  const GetSerialTVPopularFailure(this.message);
}
