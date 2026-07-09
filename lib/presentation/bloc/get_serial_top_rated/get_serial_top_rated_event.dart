part of 'get_serial_top_rated_bloc.dart';

sealed class GetSerialTopRatedEvent extends Equatable {
  const GetSerialTopRatedEvent();

  @override
  List<Object> get props => [];
}

class GetSerialTopRequested extends GetSerialTopRatedEvent {}
