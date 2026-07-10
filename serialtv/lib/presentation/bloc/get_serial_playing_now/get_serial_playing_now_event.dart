part of 'get_serial_playing_now_bloc.dart';

sealed class GetSerialPlayingNowEvent extends Equatable {
  const GetSerialPlayingNowEvent();

  @override
  List<Object> get props => [];
}

class GetSerialPlayingNowRequested extends GetSerialPlayingNowEvent {}
