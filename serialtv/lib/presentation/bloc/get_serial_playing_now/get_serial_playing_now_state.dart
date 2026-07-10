part of 'get_serial_playing_now_bloc.dart';

sealed class GetSerialPlayingNowState extends Equatable {
  const GetSerialPlayingNowState();

  @override
  List<Object> get props => [];
}

final class GetSerialPlayingNowInitial extends GetSerialPlayingNowState {}

final class GetSerialPlayingNowLoading extends GetSerialPlayingNowState {}

final class GetSerialPlayingNowLoaded extends GetSerialPlayingNowState {
  final List<SerialTV> serials;
  const GetSerialPlayingNowLoaded(this.serials);
}

final class GetSerialPlayingNowFailure extends GetSerialPlayingNowState {
  final String message;
  const GetSerialPlayingNowFailure(this.message);
}
