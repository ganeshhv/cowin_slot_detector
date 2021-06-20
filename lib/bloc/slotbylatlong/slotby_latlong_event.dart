import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class SlotByLatLongEvent extends Equatable {
  const SlotByLatLongEvent();
}

class GetSlotByLatLongApi extends SlotByLatLongEvent {
  final double lat;
  final double long;

  const GetSlotByLatLongApi({
    @required this.lat,
    @required this.long
  }) : assert(lat != null && long != null);

  @override
  List<Object> get props => [lat, long];
}
