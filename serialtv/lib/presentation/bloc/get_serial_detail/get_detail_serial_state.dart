part of 'get_detail_serial_bloc.dart';

sealed class GetDetailSerialState extends Equatable {
  const GetDetailSerialState();

  @override
  List<Object> get props => [];
}

final class GetDetailSerialInitial extends GetDetailSerialState {}

final class GetDetailSerialLoading extends GetDetailSerialState {}

final class GetDetailSerialLoaded extends GetDetailSerialState {
  final SerialTV serial;
  final bool isAddedToWatchlist;

  const GetDetailSerialLoaded(this.serial, {this.isAddedToWatchlist = false});

  GetDetailSerialLoaded copyWith({SerialTV? serial, bool? isAddedToWatchlist}) {
    return GetDetailSerialLoaded(
      serial ?? this.serial,
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
    );
  }

  @override
  List<Object> get props => [serial, isAddedToWatchlist];
}

final class GetDetailSerialFailure extends GetDetailSerialState {
  final String message;
  const GetDetailSerialFailure(this.message);
}
