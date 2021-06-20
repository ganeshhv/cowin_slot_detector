import 'package:cowin_slot_detector/models/slotbylatlong/slot_by_latlong_response.dart';
import 'package:cowin_slot_detector/repository/slotbylatlong_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class SlotByLatLongState extends Equatable
{
  const SlotByLatLongState();
  @override
  List<Object> get props => [];

}

class GetSlotByLatLongInit extends SlotByLatLongState {}

class GetSlotByLatLongLoading extends SlotByLatLongState {}

class GetSlotByLatLongSuccess extends SlotByLatLongState {
  final SlotByLatLongResponse response;
  const GetSlotByLatLongSuccess({@required this.response})
      : assert(response != null);

  @override
  List<Object> get props => [response];
}

class GetSlotByLatLongError extends SlotByLatLongState {}