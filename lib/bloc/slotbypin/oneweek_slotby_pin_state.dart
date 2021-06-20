import 'package:cowin_slot_detector/models/slotbypin/oneweek_slot_by_pin_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class OneWeekSlotState extends Equatable
{
  const OneWeekSlotState();

  @override
  List<Object> get props => [];
}

class GetOneWeekSlotInit extends OneWeekSlotState {}

class GetOneWeekSlotLoading extends OneWeekSlotState {}

class GetOneWeekSlotSuccess extends OneWeekSlotState {
  final OneweekSlotByPinResponse response;
  const GetOneWeekSlotSuccess({@required this.response})
      : assert(response != null);

  @override
  List<Object> get props => [response];
}

class GetOneWeekSlotError extends OneWeekSlotState {}


