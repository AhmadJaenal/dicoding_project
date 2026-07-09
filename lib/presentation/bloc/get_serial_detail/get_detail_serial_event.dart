part of 'get_detail_serial_bloc.dart';

sealed class GetDetailSerialEvent extends Equatable {
  const GetDetailSerialEvent();

  @override
  List<Object> get props => [];
}

class GetDetailSerialRequested extends GetDetailSerialEvent {
  final int id;
  const GetDetailSerialRequested(this.id);
}

class GetStatusWatchlistSerialRequested extends GetDetailSerialEvent {
  final int id;
  const GetStatusWatchlistSerialRequested(this.id);
}

class GetDetailSerialRecommendRequested extends GetDetailSerialEvent {}
