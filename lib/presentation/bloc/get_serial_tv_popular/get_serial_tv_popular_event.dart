part of 'get_serial_tv_popular_bloc.dart';

sealed class GetSerialTvPopularEvent extends Equatable {
  const GetSerialTvPopularEvent();

  @override
  List<Object> get props => [];
}

class GetSerialTVPopularRequested extends GetSerialTvPopularEvent {}
